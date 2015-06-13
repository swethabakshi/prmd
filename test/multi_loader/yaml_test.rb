require File.expand_path('common', File.dirname(__FILE__))
require 'nbmd_ps/multi_loader/yaml'

class NbmdPsMultiLoaderYamlTest < Minitest::Test
  include NbmdPsLoaderTests

  def loader_module
    NbmdPs::MultiLoader::Yaml
  end

  def testing_filename
    schemas_path('data/test.yaml')
  end
end
