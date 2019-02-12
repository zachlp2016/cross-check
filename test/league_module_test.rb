require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'
require './lib/game_team'
require './lib/league_methods'
require 'pry'

class LeagueMethodsTest < Minitest::Test

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
    skip
    assert_equal 20152016, @stat_tracker.best_season(2)
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
