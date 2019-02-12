module LeagueMethods
  def team_info(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end.info
  end

  def best_season(team_id)
    game_results = @game_teams.select do |game|
      game.team_id == team_id
    end
    season_results = Hash.new{|hash,key|
      hash[key] = {win: 0, loss: 0}
    }
    game_results.each do |game|
      season = game.game_id.to_s.slice(0..3)
      season += (season.to_i + 1).to_s
      result = game.won ? :win : :loss
      season_results[season][result] += 1
    end
    season_results.max_by do |season,results|
      results[:win].to_f / (results[:win] + results[:loss])
    end[0].to_i
  end
end
