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
    skip
    assert_equal "Penguins", @stat_tracker.most_accurate_team("20122013")
  end

  def test_getting_least_accurate_team
    skip
    assert_equal "Canadiens", @stat_tracker.least_accurate_team("20122013")
  end

  def test_worst_coach
   assert_equal "Jon Cooper", @stat_tracker.worst_coach("20132014")
   assert_equal "Paul Maurice", @stat_tracker.worst_coach("20142015")
 end
end
