require 'nbmd_ps/multi_loader/loader'
require 'yaml'

module NbmdPs #:nodoc:
  module MultiLoader #:nodoc:
    # YAML MultiLoader
    module Yaml
      extend NbmdPs::MultiLoader::Loader

      # @see (NbmdPs::MultiLoader::Loader#load_data)
      def self.load_data(data)
        ::YAML.load(data)
      end

      # register this loader for all .yaml and .yml files
      extensions '.yaml', '.yml'
    end
  end
end
