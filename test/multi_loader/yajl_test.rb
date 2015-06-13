require File.expand_path('common', File.dirname(__FILE__))
begin
  require 'nbmd_ps/multi_loader/yajl'
rescue LoadError
  #
end

class Nbmd_psMultiLoaderYajlTest < Minitest::Test
  include Nbmd_psLoaderTests

  def loader_module
    Nbmd_ps::MultiLoader::Yajl
  end

  def testing_filename
    schemas_path('data/test.json')
  end
end if defined?(Yajl)
