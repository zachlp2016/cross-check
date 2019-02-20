require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class LeagueStatisticsTest < Minitest::Test
  def setup
      @game_path = './test/data/game_test.csv'
      @team_path = './data/team_info.csv'
      @game_team_path = './test/data/game_teams_stats.csv'

      @game_team_test_path = './test/data/game_teams_league_stats_test.csv'
      @game_test_path = './test/data/game_league_stats_test.csv'

      @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_team_path
      }

      @test_data = {
        games: @game_test_path,
        teams: @team_path,
        game_teams: @game_team_test_path
      }

      @test_stat_tracker = StatTracker.from_csv(@test_data)
  end

  def test_method_count_of_teams
    assert_equal 33, @test_stat_tracker.count_of_teams
  end

  def test_method_best_offense_works
    assert_equal "Bruins", @test_stat_tracker.best_offense
  end

  def test_method_worst_offense_works
    assert_equal "Penguins", @test_stat_tracker.worst_offense
  end

  def test_method_best_defense_works
    assert_equal "Bruins", @test_stat_tracker.best_defense
  end

  def test_method_worst_defense_works
    assert_equal "Rangers", @test_stat_tracker.worst_defense
  end

  def test_away_team_highest_average_score
    assert_equal "Senators", @test_stat_tracker.highest_scoring_visitor
  end

  def test_home_team_highest_average_score
    assert_equal "Bruins", @test_stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Blues", @test_stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Rangers", @test_stat_tracker.lowest_scoring_home_team
  end

  def test_method_for_winningest_team
    assert_equal "Bruins", @test_stat_tracker.winningest_team
  end

  def test_method_best_fans
    assert_equal "Red Wings", @test_stat_tracker.best_fans
  end

  def test_method_worst_fans
    assert_equal [], @test_stat_tracker.worst_fans
  end
end
