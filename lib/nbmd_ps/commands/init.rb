require 'json'
require 'nbmd_ps/template'
require 'nbmd_ps/core/generator'

# :nodoc:
module NbmdPs
  # Schema generation
  module Init
    # Creates a default NbmdPs::Generator using default templates
    #
    # @return [NbmdPs::Generator]
    def self.make_generator
      base = {}
      template = NbmdPs::Template.load_template('generate_meta.json.erb', '')
      NbmdPs::Generator.new(base: base, template: template)
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
