require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))

class NbmdPsInitTest < Minitest::Test
  def test_init
	NbmdPs.generate('Cake')
  end
end
