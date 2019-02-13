require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/game'
require './lib/stat_tracker'
require './lib/team_methods'
require 'pry'

class GameMethodsTest < Minitest::Test

  def setup
    @game_path = './data/game_test.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats_test.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_highest_total_score
    assert_equal 13, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_home_and_away_games_won
    assert_equal 299 , @stat_tracker.total_home_games_won
    assert_equal  231, @stat_tracker.total_away_games_won
  end

  def test_total_games_played
    assert_equal 530, @stat_tracker.total_games
  end

  def test_percentage_home_and_away_wins
    assert_equal 0.56, @stat_tracker.percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_away_wins
  end

  def test_count_of_games_by_season
    assert_equal 86, @stat_tracker.total_count_of_games_by_season(20122013)
    assert_equal 93, @stat_tracker.total_count_of_games_by_season(20132014)
    assert_equal 89, @stat_tracker.total_count_of_games_by_season(20142015)
    assert_equal 91, @stat_tracker.total_count_of_games_by_season(20152016)
    assert_equal 87, @stat_tracker.total_count_of_games_by_season(20162017)
    assert_equal 84, @stat_tracker.total_count_of_games_by_season(20172018)
  end


end
