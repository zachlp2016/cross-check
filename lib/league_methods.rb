module LeagueMethods
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

  def best_season(team_id)
    season_results = team_win_loss_by_season(team_id)
    season_results.max_by do |season,results|
      results[:win].to_f / (results[:win] + results[:loss])
    end[0].to_i
  end

  def worst_season(team_id)
    season_results = team_win_loss_by_season(team_id)
    season_results.min_by do |season,results|
      results[:win].to_f / (results[:win] + results[:loss])
    end[0].to_i
  end

  def average_win_percentage(team_id)
    games = get_games_by_team(team_id)
    wins = games.count{|game| game.won == true}
    (wins.to_f / games.count).round(4) * 100
  end

  def most_goals_scored(team_id)
    games = get_games_by_team(team_id)
    games.max_by{|game| game.goals}.goals
  end

  def fewest_goals_scored(team_id)
    games = get_games_by_team(team_id)
    games.min_by{|game| game.goals}.goals
  end

  def favorite_opponent(team_id)
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
    favorite_id = outcomes_against.max_by do |opponent,stats|
      stats[:win].to_f / stats[:loss]
    end[0]
    get_team(favorite_id).team_name
  end
end
