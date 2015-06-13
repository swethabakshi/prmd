require 'nbmd_ps/commands/verify'
require 'nbmd_ps/rake_tasks/base'
require 'nbmd_ps/load_schema_file'

# :nodoc:
module NbmdPs
  # :nodoc:
  module RakeTasks
    # Schema Verify rake task
    #
    # @example
    #   NbmdPs::RakeTasks::Verify.new do |t|
    #     t.files << 'schema/api.json'
    #   end
    class Verify < Base
      # Schema files that should be verified
      # @return [Array<String>] list of files
      attr_accessor :files

      # Creates a new task with name +name+.
      #
      # @overload initialize(name)
      #   @param [String]
      # @overload initialize(options)
      #   @param [Hash<Symbol, Object>] options
      #     .option [Array<String>] files  schema files to verify
      def initialize(*args, &block)
        options = legacy_parameters(*args)
        @files = options.fetch(:files) { [] }
        super options, &block
      end

      private

      # Default name of the rake task
      #
      # @return [Symbol]
      def default_name
        :verify
      end

      # Defines the rake task
      #
      # @param [String] filename
      # @return [Array<String>] list of errors produced
      def verify_file(filename)
        data = NbmdPs.load_schema_file(filename)
        errors = NbmdPs.verify(data)
        unless errors.empty?
          errors.map! { |error| "#{filename}: #{error}" } if filename
          errors.each { |error| $stderr.puts(error) }
        end
        errors
      end

      protected

      # Defines the rake task
      # @return [void]
      def define
        desc 'Verifying schemas' unless Rake.application.last_comment
        task(name) do
          all_errors = []
          files.each do |filename|
            all_errors.concat(verify_file(filename))
          end
          fail unless all_errors.empty?
        end
      end
    end
  end
end
