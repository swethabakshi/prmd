require 'json'
require 'prmd/template'
require 'prmd/core/generator'

# :nodoc:
module Prmd
  # Schema generation
  module Init
    # Creates a default Prmd::Generator using default templates
    #
    # @return [Prmd::Generator]
    def self.make_generator
      base = {}
      template = Prmd::Template.load_template('generate_meta.json.erb', '')
      Prmd::Generator.new(base: base, template: template)
    end
  end

  # Generate a new JSON Schema project with a default meta(.json|yml)
  #
  # @param [String] resource
  # @param [Hash<Symbol, Object>] options
  # @return [String] schema template in YAML (yaml option was enabled) else JSON
  def self.init(company, options = {})
    gen = Init.make_generator

    generator_options = { 
      company: company, 
      level: options[:level] || 3
    }

    schema = gen.generate(generator_options)

    if options[:yaml]
      schema.to_yaml
    else
      schema.to_json
    end
  end
end
