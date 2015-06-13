require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))

class Nbmd_psInitTest < Minitest::Test
  def test_init
	Nbmd_ps.generate('Cake')
  end
end
