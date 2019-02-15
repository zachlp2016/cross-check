require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class TeamStatisticsTest < Minitest::Test

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

    @team = Team.new({
      "team_id" => 1,
      "franchiseId" => 23,
      "shortName" => "New Jersey",
      "teamName" => "Devils",
      "abbreviation" => "NJD",
      "link" => "/api/v1/teams/1"})
  end

  def test_getting_team_info
    assert_equal @team.info, @stat_tracker.team_info(1)
  end

  def test_getting_best_season_for_a_team
    assert_equal 20152016, @stat_tracker.best_season(2)
  end

  def test_getting_worst_season_for_a_team
    assert_equal 20122013, @stat_tracker.worst_season(2)
  end

  def test_getting_average_win_percentage
    assert_equal 41.67, @stat_tracker.average_win_percentage(2)
  end

  def test_getting_most_goals_scored
    assert_equal 6, @stat_tracker.most_goals_scored(2)
  end

  def test_getting_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored(2)
  end

  def test_getting_favorite_opponent
    assert_equal "Panthers", @stat_tracker.favorite_opponent(2)
  end

  def test_getting_rival
    assert_equal "Lightning", @stat_tracker.rival(2)
  end

  def test_getting_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_team_blowout(2)
  end

  def test_getting_worst_loss
    assert_equal 5, @stat_tracker.worst_loss(2)
  end

  def test_getting_head_to_head_comparison
    expectation = {win: 3, loss: 4}
    assert_equal expectation, @stat_tracker.head_to_head(2, 15)
  end

  def test_getting_seasonal_summary
    game_path = './data/game_team_2.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats_team_2.csv'
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
      playoffs: {
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
      }
    }
    assert_equal expectation_2012, stat_tracker.seasonal_summary(2)[20122013]
    assert_equal expectation_2013, stat_tracker.seasonal_summary(2)[20132014]
  end
end

# team_info                 A hash with key/value pairs for each of the attributes of a team.
# best_season               Season with the highest win percentage for a team.
# worst_season              Season with the lowest win percentage for a team.
# average_win_percentage    Average win percentage of all games for a team.
# most_goals_scored         Highest number of goals a particular team has scored in a single game.
# fewest_goals_scored       Lowest numer of goals a particular team has scored in a single game.
# favorite_opponent         Name of the opponent that has the lowest win percentage against the given team.
# rival                     Name of the opponent that has the highest win percentage against the given team.
# biggest_team_blowout      Biggest difference between team goals and opponent goals for a win for the given team.
# worst_loss                Biggest difference between team goals and opponent goals for a loss for the given team.
# head_to_head              Record (as a hash - win/loss) against a specific opponent
# seasonal_summary          For each season that the team has played, a hash that has two keys (:preseason, and :regular_season), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against
