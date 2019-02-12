require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker.rb'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test

  def setup
    @files = {
      games: './data/game.csv',
      teams: './data/team_info.csv',
      game_teams: './data/game_teams_stats.csv'
    }

    @stat_tracker = StatTracker.new(nil)
    @files_from_csv = StatTracker.from_csv(@files)
    @games = Game.new(@files_from_csv)
    binding.pry
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end

  def test_games_hold_game_data
    assert_equal @files[:games], @games.data
  end
end
