require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))
require 'nbmd_ps/cli/render'

class NbmdPsCliRenderTest < Minitest::Test
  include CliBaseTestHelpers

  def command_module
    NbmdPs::CLI::Render
  end

  def argv_for_test_run
    ['-p', 'overview.txt,somethin.txt',
     '-t', 'templates',
     '-o', 'schema/bread.md',
     'schema/bread.json']
  end

  def validate_parse_options(options)
    assert_equal ['overview.txt', 'somethin.txt'], options[:prepend]
    assert_equal 'templates', options[:template]
    assert_equal 'schema/bread.md', options[:output_file]
    assert_equal ['schema/bread.json'], options[:argv]
    super
  end
end
