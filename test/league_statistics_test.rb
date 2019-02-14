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
      @game_teams_path = './data/game_teams_stats.csv'

      @game_teams_test_path = './data/test/game_teams_league_stats_test.csv'
      @games_test_path = './data/test/game_league_stats_test.csv'
      @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }
      @locations_test = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_test_path
      }


      @stat_tracker = StatTracker.from_csv(@locations)

      @stat_tracker_test_games_teams = StatTracker.from_csv(@game_teams_data)
      @stat_tracker_test_games = StatTracker.from_csv(@games_data)


  end



  def test_method_count_of_teams
    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_method_best_offense_works
    assert_equal "Boston", @stat_tracker_test.best_offense
    assert_equal "Vegas", @stat_tracker.best_offense
  end

  def test_method_worst_offense_works
    assert_equal "Pittsburgh", @stat_tracker_test.worst_offense
    assert_equal "Buffalo", @stat_tracker.worst_offense
  end
end
