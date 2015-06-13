require 'nbmd_ps/commands/render'
require 'nbmd_ps/rake_tasks/base'
require 'nbmd_ps/load_schema_file'
require 'nbmd_ps/template'
require 'nbmd_ps/schema'

# :nodoc:
module NbmdPs
  # :nodoc:
  module RakeTasks
    # Documentation rake task
    #
    # @example
    #   NbmdPs::RakeTasks::Doc.new do |t|
    #     t.files = { 'schema/api.json' => 'schema/api.md' }
    #   end
    class Doc < Base
      # Schema files that should be verified
      # @return [Array<String>, Hash<String, String>] list of files
      attr_accessor :files

      # Creates a new task with name +name+.
      #
      # @overload initialize(name)
      #   @param [String]
      # @overload initialize(options)
      #   @param [Hash<Symbol, Object>] options
      #     .option [Array<String>, Hash<String, String>] files  schema files
      def initialize(*args, &block)
        options = legacy_parameters(*args)
        @files = options.fetch(:files) { [] }
        super options, &block
        @options[:template] ||= NbmdPs::Template.template_dirname
      end

      private

      # Default name of the rake task
      #
      # @return [Symbol]
      def default_name
        :doc
      end

      # Render file to markdown
      #
      # @param [String] filename
      # @return (see NbmdPs.render)
      def render_file(filename)
        data = NbmdPs.load_schema_file(filename)
        schema = NbmdPs::Schema.new(data)
        NbmdPs.render(schema, options)
      end

      # Render +infile+ to +outfile+
      #
      # @param [String] infile
      # @param [String] outfile
      # @return [void]
      def render_to_file(infile, outfile)
        result = render_file(infile)
        if outfile
          File.open(outfile, 'w') do |file|
            file.write(result)
          end
        end
      end

      protected

      # Defines the rake task
      # @return [void]
      def define
        desc 'Verifying schemas' unless Rake.application.last_comment
        task(name) do
          if files.is_a?(Hash)
            files.each do |infile, outfile|
              render_to_file(infile, outfile)
            end
          else
            files.each do |infile|
              render_to_file(infile, infile.ext('md'))
            end
          end
        end
      end
    end
  end
end
