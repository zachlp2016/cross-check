require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/stat_tracker'
require './lib/team_methods'

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

  end

end
