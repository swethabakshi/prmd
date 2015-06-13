require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))

class PrmdInitTest < Minitest::Test
  def test_init
	Prmd.generate('Cake')
  end
end
