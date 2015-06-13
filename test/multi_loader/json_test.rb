require File.expand_path('common', File.dirname(__FILE__))
require 'nbmd_ps/multi_loader/json'

class NbmdPsMultiLoaderJsonTest < Minitest::Test
  include NbmdPsLoaderTests

  def loader_module
    NbmdPs::MultiLoader::Json
  end

  def testing_filename
    schemas_path('data/test.json')
  end
end
