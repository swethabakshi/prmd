require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))
require 'nbmd_ps/cli/doc'

class NbmdPsCliDocTest < Minitest::Test
  include CliBaseTestHelpers

  def command_module
    NbmdPs::CLI::Doc
  end

  def argv_for_test_run
    ['-s', input_schemas_path('doc-settings.json'),
     '-p', 'overview.txt',
     'schema/api.json',
     '-o', 'schema/verified-api.json']
  end

  def validate_parse_options(options)
    assert_equal 'application/bread', options[:content_type]
    assert_equal ['overview.txt'], options[:prepend]
    assert_equal 'schema/verified-api.json', options[:output_file]
    assert_equal ['schema/api.json'], options[:argv]
    super
  end
end
