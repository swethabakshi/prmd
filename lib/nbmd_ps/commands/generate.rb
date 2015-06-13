require 'json'
require 'nbmd_ps/template'
require 'nbmd_ps/core/generator'

# :nodoc:
module NbmdPs
  # Schema generation
  module Generate
    # Creates a default NbmdPs::Generator using default templates
    #
    # @return [NbmdPs::Generator]
    def self.make_generator(tpl_name = nil)
      base = NbmdPs::Template.load_json('generate_default.json')
      template = NbmdPs::Template.load_template(tpl_name || 'generate_resource.json.erb', '')
      NbmdPs::Generator.new(base: base, template: template)
    end
  end

  # Generate a schema template
  #
  # @param [String] resource
  # @param [Hash<Symbol, Object>] options
  # @return [String] schema template in YAML (yaml option was enabled) else JSON
  def self.generate(resource, options = {})
    gen = Generate.make_generator(options[:tpl])

    generator_options = { resource: nil, parent: nil }
    if resource
      parent = nil
      parent, resource = resource.split('/') if resource.include?('/')
      generator_options[:parent] = parent
      generator_options[:resource] = resource
      generator_options[:level] = options[:level] ? options[:level].to_i : 3
    end

    schema = gen.generate(generator_options)

    if options[:yaml]
      schema.to_yaml
    else
      schema.to_json
    end
  end
end
