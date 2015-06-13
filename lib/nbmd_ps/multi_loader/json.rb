require 'nbmd_ps/multi_loader/loader'
require 'json'

module NbmdPs #:nodoc:
  module MultiLoader #:nodoc:
    # JSON MultiLoader
    module Json
      extend NbmdPs::MultiLoader::Loader

      # @see (NbmdPs::MultiLoader::Loader#load_data)
      def self.load_data(data)
        ::JSON.load(data)
      end

      # register this loader for all .json files
      extensions '.json'
    end
  end
end
