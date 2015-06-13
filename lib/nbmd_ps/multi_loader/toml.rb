require 'nbmd_ps/multi_loader/loader'
require 'toml'

module NbmdPs #:nodoc:
  module MultiLoader #:nodoc:
    # TOML MultiLoader
    module Toml
      extend NbmdPs::MultiLoader::Loader

      # @see (NbmdPs::MultiLoader::Loader#load_data)
      def self.load_data(data)
        ::TOML.load(data)
      end

      # register this loader for all .toml files
      extensions '.toml'
    end
  end
end
