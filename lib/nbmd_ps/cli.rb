require 'nbmd_ps/core_ext/optparse'
require 'nbmd_ps/cli/init'
require 'nbmd_ps/cli/combine'
require 'nbmd_ps/cli/doc'
require 'nbmd_ps/cli/generate'
require 'nbmd_ps/cli/render'
require 'nbmd_ps/cli/verify'

# :nodoc:
module NbmdPs
  # Main CLI module
  module CLI
    # @param [Hash<Symbol, Object>] props
    # @return [Hash<Symbol, OptionParser>] all dem parsers
    def self.make_command_parsers(props = {})
      {
        init:     CLI::Init.make_parser(props),
        combine:  CLI::Combine.make_parser(props),
        doc:      CLI::Doc.make_parser(props),
        generate: CLI::Generate.make_parser(props),
        render:   CLI::Render.make_parser(props),
        verify:   CLI::Verify.make_parser(props)
      }
    end

    # List of all available commands
    #
    # @return [Array] available commands
    def self.commands
      @commands ||= make_command_parsers.keys
    end

    # Creates the CLI main parser
    #
    # @param [Hash<Symbol, Object>] options
    # @param [Hash<Symbol, Object>] props
    def self.make_parser(options, props = {})
      binname = props.fetch(:bin, 'nbmd_ps')

      # This is only used to attain the help commands
      commands = make_command_parsers(props)
      help_text = commands.values.map do |command|
        "   #{command.banner}"
      end.join("\n")

      global = OptionParser.new do |opts|
        opts.banner = "Usage: #{binname} [options] [command [options]]"
        opts.separator "\nAvailable options:"
        opts.on('--version', 'Return version') do
          puts "nbmd_ps #{NbmdPs::VERSION}"
          exit(0)
        end
        opts.on('--noop', 'Commands will not execute') do |v|
          options[:noop] = v
        end
        opts.separator "\nAvailable commands:"
        opts.separator help_text
      end

      global
    end

    # Parse top level CLI options from argv
    #
    # @param [Array<String>] argv
    # @param [Hash<Symbol, Object>] opts
    # @return [Hash<Symbol, Object>] parsed options
    def self.parse_options(argv, opts = {})
      options = {}
      parser = make_parser(options, opts)
      abort parser if argv.empty?
      com_argv = parser.order(argv)
      abort parser if com_argv.empty?
      command = com_argv.shift.to_sym
      abort parser unless commands.include?(command)
      options[:argv] = com_argv
      options[:command] = command
      options
    end

    # Execute the NbmdPs CLI, or its subcommands
    #
    # @param [Array<String>] uargv
    # @param [Hash<Symbol, Object>] opts
    # @return [void]
    def self.run(uargv, opts = {})
      options = parse_options(uargv, opts)
      argv = options.delete(:argv)
      command = options.delete(:command)

      case command
      when :init
        CLI::Init.run(argv, options)
      when :combine
        CLI::Combine.run(argv, options)
      when :doc
        CLI::Doc.run(argv, options)
      when :generate
        CLI::Generate.run(argv, options)
      when :render
        CLI::Render.run(argv, options)
      when :verify
        CLI::Verify.run(argv, options)
      end
    end

    class << self
      private :make_command_parsers
      private :commands
    end
  end
end
