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
    @team = Team.new({
      "team_id" => 1,
      "franchiseId" => 23,
      "shortName" => "New Jersey",
      "teamName" => "Devils",
      "abbreviation" => "NJD",
      "link" => "/api/v1/teams/1"
      })

    @team_2 = Team.new({
      "team_id" => 4,
      "franchiseId" => 16,
      "shortName" => "Philadelphia",
      "teamName" => "Flyers",
      "abbreviation" => "PHI",
      "link" => "/api/v1/teams/4"
      })

    @team_3 = Team.new({
      "team_id" => 26,
      "franchiseId" => 14,
      "shortName" => "Los Angeles",
      "teamName" => "Kings",
      "abbreviation" => "LAK",
      "link" => "/api/v1/teams/26"
      })

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
end
