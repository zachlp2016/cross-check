class Team
  attr_reader :team_id,
              :franchise_id,
              :short_name,
              :team_name,
              :abbreviation,
              :link
  def initialize(team_details)
    @team_id = team_details["team_id"]
    @franchise_id = team_details["franchiseId"]
    @short_name = team_details["shortName"]
    @team_name = team_details["teamName"]
    @abbreviation = team_details["abbreviation"]
    @link = team_details["link"]
  end

  def info
    {"team_id" => @team_id,
    "franchise_id" => @franchise_id,
    "short_name" => @short_name,
    "team_name" => @team_name,
    "abbreviation" => @abbreviation,
    "link" => @link}
  end
end
