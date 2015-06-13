require File.expand_path('common', File.dirname(__FILE__))
require 'nbmd_ps/multi_loader/json'

class Nbmd_psMultiLoaderJsonTest < Minitest::Test
  include Nbmd_psLoaderTests

  def loader_module
    Nbmd_ps::MultiLoader::Json
  end

  def testing_filename
    schemas_path('data/test.json')
  end
end
