require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))
require 'nbmd_ps/cli/combine'

class Nbmd_psCliCombineTest < Minitest::Test
  include CliBaseTestHelpers

  def command_module
    Nbmd_ps::CLI::Combine
  end

  def argv_for_test_run
    ['-m', 'schema/meta.json',
     'schema/schemata',
     '-o', 'schema/api.json']
  end

  def validate_parse_options(options)
    assert_equal 'schema/meta.json', options[:meta]
    assert_equal 'schema/api.json', options[:output_file]
    assert_equal ['schema/schemata'], options[:argv]
    super
  end
end
