module HelperMethods
  def get_team(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  def team_info(team_id)
    get_team(team_id).info
  end

  def get_games_by_team(team_id)
    @game_teams.select {|game| game.team_id == team_id}
  end

  def team_win_loss_by_season(team_id)
    game_results = get_games_by_team(team_id)
    season_results = Hash.new{|hash,key|
      hash[key] = {win: 0, loss: 0}
    }
    game_results.each do |game|
      season = game.game_id.to_s.slice(0..3)
      season += (season.to_i + 1).to_s
      result = game.won ? :win : :loss
      season_results[season][result] += 1
    end
    return season_results
  end
end
