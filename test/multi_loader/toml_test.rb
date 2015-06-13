require File.expand_path('common', File.dirname(__FILE__))
begin
  require 'nbmd_ps/multi_loader/toml'
rescue LoadError
  #
end

class Nbmd_psMultiLoaderTomlTest < Minitest::Test
  include Nbmd_psLoaderTests

  def loader_module
    Nbmd_ps::MultiLoader::Toml
  end

  def testing_filename
    schemas_path('data/test.toml')
  end
end if defined?(TOML)
