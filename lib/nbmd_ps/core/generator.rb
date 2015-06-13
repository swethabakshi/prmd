require 'json'
require 'nbmd_ps/schema'

# :nodoc:
module NbmdPs
  # Schema generator
  class Generator
    #
    # @param [Hash<Symbol, Object>] properties
    def initialize(properties = {})
      @properties = properties
      @base = properties.fetch(:base, {})
      @template = properties.fetch(:template)
    end

    #
    # @param [Hash<Symbol, Object>] options
    def generate(options = {})
      res = @template.result(options)
      resource_schema = JSON.parse(res)
      schema = NbmdPs::Schema.new
      schema.merge!(@base)
      schema.merge!(resource_schema)
      schema
    end
  end
end
