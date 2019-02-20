require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class GameMethodsTest < Minitest::Test
  def setup
    @game_path = './test/data/game_test.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './test/data/game_teams_stats_test.csv'
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
    assert_equal 7, @stat_tracker.biggest_blowout
  end

  def test_home_and_away_games_won
    assert_equal 299 , @stat_tracker.total_games_won_by_location("home")
    assert_equal  231, @stat_tracker.total_games_won_by_location("away")
  end

  def test_total_games_played
    assert_equal 530.0, @stat_tracker.total_games
  end

  def test_percentage_home_and_away_wins
    assert_equal 0.56, @stat_tracker.percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_visitor_wins
  end

  def test_count_of_games_by_season
    expected = {
      "20122013"=>86,
      "20162017"=>87,
      "20142015"=>89,
      "20152016"=>91,
      "20132014"=>93,
      "20172018"=>84
    }

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 5.33, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>5.02,
      "20162017"=>5.16,
      "20142015"=>5.03,
      "20152016"=>5.25,
      "20132014"=>5.59,
      "20172018"=>5.9
    }

    assert_equal expected, @stat_tracker.average_goals_by_season
  end

end
