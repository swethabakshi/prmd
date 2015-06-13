require 'nbmd_ps/url_generators/generators/default'
require 'nbmd_ps/url_generators/generators/json'

# :nodoc:
module NbmdPs
  # Schema URL Generation
  # @api private
  class UrlGenerator
    # @param [Hash<Symbol, Object>] params
    def initialize(params)
      @schema = params[:schema]
      @link = params[:link]
      @options = params.fetch(:options)
    end

    # @return [Array]
    def url_params
      if @options[:doc][:url_style].downcase == 'json'
        klass = Generators::JSON
      else
        klass = Generators::Default
      end

      klass.generate(schema: @schema, link: @link)
    end
  end
end
