require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class TeamStatisticsTest < Minitest::Test
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

    @team = Team.new({
      "team_id" => "1",
      "franchiseId" => "23",
      "shortName" => "New Jersey",
      "teamName" => "Devils",
      "abbreviation" => "NJD",
      "link" => "/api/v1/teams/1"})
  end

  def test_getting_team_info
    assert_equal @team.info, @stat_tracker.team_info("1")
  end

  def test_getting_best_season_for_a_team
    assert_equal "20152016", @stat_tracker.best_season("2")
  end

  def test_getting_worst_season_for_a_team
    assert_equal "20122013", @stat_tracker.worst_season("2")
  end

  def test_getting_average_win_percentage
    assert_equal 0.42, @stat_tracker.average_win_percentage("2")
  end

  def test_getting_most_goals_scored
    assert_equal 6, @stat_tracker.most_goals_scored("2")
  end

  def test_getting_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("2")
  end

  def test_getting_favorite_opponent
    assert_equal "Panthers", @stat_tracker.favorite_opponent("2")
  end

  def test_getting_rival
    assert_equal "Lightning", @stat_tracker.rival("2")
  end

  def test_getting_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_team_blowout("2")
  end

  def test_getting_worst_loss
    assert_equal 5, @stat_tracker.worst_loss("2")
  end

  def test_getting_head_to_head_comparison
    expectation = {
      "Lightning" => 0.2,
      "Capitals" => 0.43,
      "Penguins" => 0.33,
      "Panthers" => 0.67
    }
    assert_equal expectation, @stat_tracker.head_to_head("2")
  end

  def test_getting_seasonal_summary
    game_path = './test/data/game_team_2.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './test/data/game_teams_stats_team_2.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    expectation_2012 = {
      regular_season: {
        win_percentage: 0.50,
        total_goals_scored: 139,
        total_goals_against: 139,
        average_goals_scored: 2.90,
        average_goals_against: 2.90
      },
      preseason: {
        win_percentage: 0.33,
        total_goals_scored: 17,
        total_goals_against: 25,
        average_goals_scored: 2.83,
        average_goals_against: 4.17
      }
    }
    expectation_2013 = {
      regular_season: {
        win_percentage: 0.41,
        total_goals_scored: 225,
        total_goals_against: 267,
        average_goals_scored: 2.74,
        average_goals_against: 3.26
      },
      preseason: {
        win_percentage: 0.0,
        total_goals_scored: 0,
        total_goals_against: 0,
        average_goals_scored: 0.0,
        average_goals_against: 0.0
      }
    }
    assert_equal expectation_2012, stat_tracker.seasonal_summary("2")["20122013"]
    assert_equal expectation_2013, stat_tracker.seasonal_summary("2")["20132014"]
  end
end
