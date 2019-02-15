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

      # @stat_tracker = StatTracker.from_csv(@locations)

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
    assert_equal "Boston", @test_stat_tracker.best_offense
  end

  def test_method_worst_offense_works
    assert_equal "Pittsburgh", @test_stat_tracker.worst_offense
  end

  def test_method_goals_per_team
    hash = {
      "3" => 0,
      "6" => 0,
      "5" => 0,
      "17" => 0,
      "16" => 0
    }
    assert_equal hash, @test_stat_tracker.goals_per_team
  end

  def test_method_goals_accumulation
    hash = {
      "3" => 23,
      "6" => 7,
      "5" => 16,
      "17" => 10,
      "16" => 11
    }
      assert_equal hash, @test_stat_tracker.goals_accumulation
  end

  def test_method_game_count_works
    hash = {
      "3"=>5,
      "6"=>9,
      "5"=>4,
      "17"=>5,
      "16"=>5
    }
    assert_equal hash, @test_stat_tracker.games_accumulation
  end

  def test_method_best_defense_works
    assert_equal "Boston", @test_stat_tracker.best_defense
  end

  def test_method_worst_defense_works
    assert_equal "NY Rangers", @test_stat_tracker.worst_defense
  end
end
