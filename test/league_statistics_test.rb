require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/game_team'
require './lib/game'
require './lib/stat_tracker'
require './lib/league_statistics'
require 'pry'

class LeagueStatisticsTest < Minitest::Test

  def setup

      @game_path = './data/game_test.csv'
      @team_path = './data/team_info.csv'
      @game_team_path = './data/game_teams_stats.csv'

      @game_team_test_path = './data/test/game_teams_league_stats_test.csv'
      @game_test_path = './data/test/game_league_stats_test.csv'

      @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_team_path
      }

      @stat_tracker = StatTracker.from_csv(@locations)

      @test_data = {
        games: @game_test_path,
        teams: @team_path,
        game_teams: @game_team_test_path
      }

      @test_stat_tracker = StatTracker.from_csv(@test_data)

  end



  def test_method_count_of_teams
    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_method_best_offense_works
    assert_equal "Boston", @test_stat_tracker.best_offense
    assert_equal "Vegas", @stat_tracker.best_offense
  end

  def test_method_worst_offense_works
    assert_equal "Pittsburgh", @test_stat_tracker.worst_offense
    assert_equal "Buffalo", @stat_tracker.worst_offense
  end

  def test_method_best_defense_works
    assert_equal "Boston", @test_stat_tracker.best_defense
  end

  def test_method_worst_defense_works
    skip
    assert_equal "NY Rangers", @test_stat_tracker.worst_defense
  end
end
