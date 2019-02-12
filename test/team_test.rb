require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'
require 'pry'

class TeamTest < Minitest::Test
  def setup
    # @files = {
    #   games: './data/game_test.csv',
    #   teams: './data/team_info.csv',
    #   game_teams: './data/game_teams_stats_test.csv'
    # }
    # @stat_tracker = StatTracker.from_csv(@files)

    @team = Team.new({
      "team_id" => 1,
      "franchiseId" => 23,
      "shortName" => "New Jersey",
      "teamName" => "Devils",
      "abbreviation" => "NJD",
      "link" => "/api/v1/teams/1"})
  end

  def test_team_exists
    assert_instance_of Team, @team
  end

  def test_team_attributes_initialize_correctly
    assert_equal 1, @team.team_id
    assert_equal 23, @team.franchise_id
    assert_equal "New Jersey", @team.short_name
    assert_equal "Devils", @team.team_name
    assert_equal "NJD", @team.abbreviation
    assert_equal "/api/v1/teams/1", @team.link
  end
end
