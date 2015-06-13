require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))
require 'nbmd_ps/cli/generate'

class Nbmd_psCliGenerateTest < Minitest::Test
  include CliBaseTestHelpers

  def command_module
    Nbmd_ps::CLI::Generate
  end

  def argv_for_test_run
    ['-y',
     'bread',
     '-o', 'schema/bread.yml']
  end

  def validate_parse_options(options)
    assert_equal true, options[:yaml]
    assert_equal ['bread'], options[:argv]
    assert_equal 'schema/bread.yml', options[:output_file]
    super
  end
end
