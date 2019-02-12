require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end
end
