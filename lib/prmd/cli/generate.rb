require 'prmd/cli/base'
require 'prmd/commands/generate'

module Prmd
  module CLI
    # 'generate' command module.
    # Creating new Schema files
    module Generate
      extend CLI::Base

      # Returns a OptionParser for parsing 'generate' command options.
      #
      # @param (see Prmd::CLI::Base#make_parser)
      # @return (see Prmd::CLI::Base#make_parser)
      def self.make_parser(options = {})
        binname = options.fetch(:bin, 'prmd')

        OptionParser.new do |opts|
          opts.banner = "#{binname} generate [options] <resource name>"
          opts.on('-y', '--yaml', 'Generate YAML') do |y|
            yield :yaml, y
          end
          opts.on('-l', '--level 2', 'Supplier API Level: 1 (no automation) to 3 (full automation). Default: 3') do |y|
            yield :level, (y || 3)
          end
          opts.on('-o', '--output-file FILENAME', String, 'File to write result to') do |n|
            yield :output_file, n
          end
        end
      end

      # Executes the 'generate' command.
      #
      # @example Usage
      #   Prmd::CLI::Generate.execute(argv: ['bread'],
      #                               output_file: 'schema/schemata/bread.json')
      #
      # @param (see Prmd::CLI::Base#execute)
      # @return (see Prmd::CLI::Base#execute)
      def self.execute(options = {})
        name = options.fetch(:argv).join(' ').underscore
        abort("No resource name supplied") unless name.present?
        write_result Prmd.generate(name, options), options
      end
    end
  end
end
