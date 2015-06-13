require 'yaml'
require 'json'
require 'nbmd_ps/multi_loader'

module NbmdPs #:nodoc:
  # Attempts to load either a json or yaml file, the type is determined by
  # filename extension.
  #
  # @param [String] filename
  # @return [Object] data
  def self.load_schema_file(filename)
    NbmdPs::MultiLoader.load_file(filename)
  end
end
