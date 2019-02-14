module HelperMethods
  def get_team(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
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

  def get_outcomes_by_opponent(team_id)
    games = get_games_by_team(team_id)
    outcomes_against = Hash.new{|hash,opponent|
      hash[opponent] = {win: 0, loss: 0}
    }
    games.each do |target_game|
      opponent = @game_teams.find do |game|
        game.game_id == target_game.game_id &&
        game.team_id != target_game.team_id
      end.team_id
      outcome = target_game.won ? :win : :loss
      outcomes_against[opponent][outcome] += 1
    end
    return outcomes_against
  end
end
