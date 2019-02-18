require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class SeasonStatisticsTest < Minitest::Test

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

  def test_getting_most_accurate_team
    assert_equal "Penguins", @stat_tracker.most_accurate_team("20122013")
  end

  def test_getting_least_accurate_team
    assert_equal "Canadiens", @stat_tracker.least_accurate_team("20122013")
  end

  def test_getting_most_hits
    assert_equal "Bruins", @stat_tracker.most_hits("20122013")
  end

  def test_getting_least_hits
    assert_equal "Canucks", @stat_tracker.least_hits("20122013")
  end

  def test_getting_power_play_goal_percentage
    assert_equal 0.22, @stat_tracker.power_play_goal_percentage("20122013")
  end
end
