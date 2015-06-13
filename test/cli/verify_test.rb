require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))
require 'nbmd_ps/cli/verify'

class Nbmd_psCliVerifyTest < Minitest::Test
  include CliBaseTestHelpers

  def command_module
    Nbmd_ps::CLI::Verify
  end

  def argv_for_test_run
    ['-o', 'schema/buttered-bread.json',
     'schema/bread.json']
  end

  def validate_parse_options(options)
    assert_equal 'schema/buttered-bread.json', options[:output_file]
    assert_equal ['schema/bread.json'], options[:argv]
    super
  end
end
