require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/game'
require './lib/stat_tracker'
require './lib/team_methods'

require 'pry'

class TeamMethodsTest < Minitest::Test

  def setup
    @game_team_1
    @game_team_2
    @game_team_3
    @game_team_4
    @game_team_5
    @game_team_6

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

  def test_method_count_of_teams
    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_method_best_offense_works
    assert_equal "Pittsburgh", @stat_tracker.best_offense
  end

  def test_method_best_defense_works
    assert_equal "Philadelphia", @stat_tracker.worst_offense
  end
end
