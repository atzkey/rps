class RpsTest < ActiveSupport::TestCase
  test 'it plays the game, defined by the rules' do
    # A Kitsune-ken game
    game = Rps.new({
      'fox' => ['mayor'],
      'mayor' => ['hunter'],
      'hunter' => ['fox']
    })

    assert_equal :tie, game.match('fox', 'fox')
    assert_equal :loss, game.match('mayor', 'fox')
    assert_equal :win, game.match('fox', 'mayor')
    assert_nil game.match('unknown', 'fox')
    assert_nil game.match('fox', 'unknown')
  end
end
