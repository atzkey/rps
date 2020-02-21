class RpsTest < ActiveSupport::TestCase
  test 'it plays the game, defined by the rules' do
    # A 狐拳 (kitsune-ken) game
    game = Rps.new({
      '狐' => ['庄屋'],
      '庄屋' => ['猟師'],
      '猟師' => ['狐']
    })

    assert_equal :tie, game.match('狐', '狐')
    assert_equal :loss, game.match('庄屋', '狐')
    assert_equal :win, game.match('狐', '庄屋')
    assert_nil game.match('何', '狐')
    assert_nil game.match('狐', '何')
  end
end