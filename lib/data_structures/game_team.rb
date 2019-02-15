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
    @won = details["won"]
    @settled_in = details["settled_in"]
    @head_coach = details["head_coach"]
    @goals = details["goals"]
    @shots = details["shots"]
    @hits = details["hits"]
    @pim = details["pim"]
    @power_play_opportunities = details["powerPlayOpportunities"]
    @power_play_goals = details["powerPlayGoals"]
    @face_off_win_percentage = details["faceOffWinPercentage"]
    @giveaways = details["giveaways"]
    @takeaways = details["takeaways"]
  end
end
