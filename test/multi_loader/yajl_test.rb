require File.expand_path('common', File.dirname(__FILE__))
begin
  require 'nbmd_ps/multi_loader/yajl'
rescue LoadError
  #
end

class NbmdPsMultiLoaderYajlTest < Minitest::Test
  include NbmdPsLoaderTests

  def loader_module
    NbmdPs::MultiLoader::Yajl
  end

  def testing_filename
    schemas_path('data/test.json')
  end
end if defined?(Yajl)
