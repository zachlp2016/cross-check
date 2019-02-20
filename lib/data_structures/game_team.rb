class GameTeam
  attr_reader :game_id,
              :team_id,
              :home_or_away,
              :won,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :hits,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(details)
    @game_id = details["game_id"]
    @team_id = details["team_id"]
    @home_or_away = details["HoA"]
    @won = convert_boolean_string(details["won"])
    @settled_in = details["settled_in"]
    @head_coach = details["head_coach"]
    @goals = details["goals"].to_i
    @shots = details["shots"].to_i
    @hits = details["hits"].to_i
    @pim = details["pim"].to_i
    @power_play_opportunities = details["powerPlayOpportunities"].to_i
    @power_play_goals = details["powerPlayGoals"].to_i
    @face_off_win_percentage = details["faceOffWinPercentage"].to_f
    @giveaways = details["giveaways"].to_i
    @takeaways = details["takeaways"].to_i
  end

  def convert_boolean_string(str)
    if str == "TRUE"
      true
    elsif str == "FALSE"
      false
    else
      str
    end
  end
end
