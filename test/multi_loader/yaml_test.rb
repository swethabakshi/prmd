require File.expand_path('common', File.dirname(__FILE__))
require 'nbmd_ps/multi_loader/yaml'

class Nbmd_psMultiLoaderYamlTest < Minitest::Test
  include Nbmd_psLoaderTests

  def loader_module
    Nbmd_ps::MultiLoader::Yaml
  end

  def testing_filename
    schemas_path('data/test.yaml')
  end
end
