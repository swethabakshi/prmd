require 'nbmd_ps/multi_loader/loader'
require 'yajl'

module NbmdPs #:nodoc:
  module MultiLoader #:nodoc:
    # JSON MultiLoader using Yajl
    module Yajl
      extend NbmdPs::MultiLoader::Loader

      # @see (NbmdPs::MultiLoader::Loader#load_data)
      def self.load_data(data)
        ::Yajl::Parser.parse(data)
      end

      # register this loader for all .json files
      extensions '.json'
    end
  end
end
