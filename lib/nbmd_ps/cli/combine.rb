require 'nbmd_ps/cli/base'
require 'nbmd_ps/commands/combine'

module NbmdPs
  module CLI
    # 'combine' command module.
    module Combine
      extend CLI::Base

      # Returns a OptionParser for parsing 'combine' command options.
      #
      # @param (see NbmdPs::CLI::Base#make_parser)
      # @return (see NbmdPs::CLI::Base#make_parser)
      def self.make_parser(options = {})
        binname = options.fetch(:bin, 'nbmd_ps')

        OptionParser.new do |opts|
          opts.banner = "#{binname} combine [options] <file or directory>"
          opts.on('-m', '--meta FILENAME', String, 'Set defaults for schemata') do |m|
            yield :meta, m
          end
          opts.on('-o', '--output-file FILENAME', String, 'File to write result to') do |n|
            yield :output_file, n
          end
        end
      end

      # Executes the 'combine' command.
      #
      # @example Usage
      #   NbmdPs::CLI::Combine.execute(argv: ['schema/schemata/api'],
      #                              meta: 'schema/meta.json',
      #                              output_file: 'schema/api.json')
      #
      # @param (see NbmdPs::CLI::Base#execute)
      # @return (see NbmdPs::CLI::Base#execute)
      def self.execute(options = {})
        write_result NbmdPs.combine(options[:argv], options).to_s, options
      end
    end
  end
end
