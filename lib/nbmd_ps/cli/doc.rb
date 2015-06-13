require 'nbmd_ps/cli/base'
require 'nbmd_ps/commands/render'
require 'nbmd_ps/hash_helpers'

module NbmdPs
  module CLI
    # 'doc' command module.
    module Doc
      extend CLI::Base

      # Returns a OptionParser for parsing 'doc' command options.
      #
      # @param (see NbmdPs::CLI::Base#make_parser)
      # @return (see NbmdPs::CLI::Base#make_parser)
      def self.make_parser(options = {})
        binname = options.fetch(:bin, 'nbmd_ps')

        OptionParser.new do |opts|
          opts.banner = "#{binname} doc [options] <combined schema>"
          opts.on('-s', '--settings FILENAME', String, 'Config file to use') do |s|
            settings = NbmdPs.load_schema_file(s) || {}
            options = HashHelpers.deep_symbolize_keys(settings)
            yield :settings, options
          end
          opts.on('-p', '--prepend header,overview', Array, 'Prepend files to output') do |p|
            yield :prepend, p
          end
          opts.on('-c', '--content-type application/json', String, 'Content-Type header') do |c|
            yield :content_type, c
          end
          opts.on('-o', '--output-file FILENAME', String, 'File to write result to') do |n|
            yield :output_file, n
          end
        end
      end

      # Overwritten to support :settings merging.
      #
      # @see NbmdPs::CLI::Base#set_option
      #
      # @param (see NbmdPs::CLI::Base#set_option)
      # @return (see NbmdPs::CLI::Base#set_option)
      def self.set_option(options, key, value)
        if key == :settings
          options.replace(value.merge(options))
        else
          super
        end
      end

      # Executes the 'doc' command.
      #
      # @example Usage
      #   NbmdPs::CLI::Doc.execute(argv: ['schema/api.json'],
      #                          output_file: 'schema/api.md')
      #
      # @param (see NbmdPs::CLI::Base#execute)
      # @return (see NbmdPs::CLI::Base#execute)
      def self.execute(options = {})
        filename = options.fetch(:argv).first
        template = File.expand_path('templates', File.dirname(__FILE__))
        _, data = try_read(filename)
        schema = NbmdPs::Schema.new(data)
        opts = options.merge(template: template)
        write_result NbmdPs.render(schema, opts), options
      end
    end
  end
end
