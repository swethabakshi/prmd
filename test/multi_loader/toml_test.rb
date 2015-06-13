require File.expand_path('common', File.dirname(__FILE__))
begin
  require 'nbmd_ps/multi_loader/toml'
rescue LoadError
  #
end

class NbmdPsMultiLoaderTomlTest < Minitest::Test
  include NbmdPsLoaderTests

  def loader_module
    NbmdPs::MultiLoader::Toml
  end

  def testing_filename
    schemas_path('data/test.toml')
  end
end if defined?(TOML)
