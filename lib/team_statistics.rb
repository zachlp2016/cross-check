module TeamStatistics
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
    wins = games.count{|game| game.won}
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

  def favorite_opponent(team_id)
    outcomes_against = get_outcomes_by_opponent(team_id)
    favorite_id = outcomes_against.max_by do |opponent,stats|
      stats[:win].to_f / stats[:loss]
    end[0]
    get_team(favorite_id).team_name
  end

  def rival(team_id)
    outcomes_against = get_outcomes_by_opponent(team_id)
    rival_id = outcomes_against.min_by do |opponent,stats|
      stats[:win].to_f / stats[:loss]
    end[0]
    get_team(rival_id).team_name
  end

  def biggest_team_blowout(team_id)
    wins = @games.select do |game|
      (game.away_team_id == team_id &&
       game.away_goals > game.home_goals) ||
      (game.home_team_id == team_id &&
       game.home_goals > game.away_goals)
    end
    max = wins.max_by{|game| (game.away_goals - game.home_goals).abs}
    (max.away_goals - max.home_goals).abs
  end

  def worst_loss(team_id)
    losses = @games.select do |game|
      (game.away_team_id == team_id &&
       game.away_goals < game.home_goals) ||
      (game.home_team_id == team_id &&
       game.home_goals < game.away_goals)
    end
    max = losses.max_by{|game| (game.away_goals - game.home_goals).abs}
    (max.away_goals - max.home_goals).abs
  end

  def head_to_head(team_id, opponent_id)
    get_outcomes_by_opponent(team_id)[opponent_id]
  end

  def seasonal_summary(team_id)
    summary = Hash.new{|summary,season|
      summary[season] = Hash.new{|season,stage|
        season[stage] = Hash.new{|type,stat|
          type[stat] = 0
        }
      }
    }
    counter = Hash.new{|counter,season|
      counter[season] = Hash.new{|season,stage|
        season[stage] = [total: 0, wins: 0]
      }
    }
    @games.each do |game|
      type = game.type == "P" ? :playoffs : :regular_season
      location = game.home_team_id == team_id ? ["home", "away"] : ["away", "home"]
      summary[game.season][type][:total_goals_scored] += game.send("#{location[0]}_goals")
      summary[game.season][type][:total_goals_against] += game.send("#{location[1]}_goals")
      counter[game.season][type][:wins] += 1 if game.send("#{location[0]}_goals") > game.send("#{location[1]}_goals")
    end
    summary.each do |summary,season|
      [:playoffs,:regular_season].each do |type|
        if season.has_key?(type)
          season[type][:win_percentage] = (counter[season][type].to_f / season[type].length).round(2)
          season[type][:average_goals_scored] = (season[type][:total_goals_scored].to_f / season[type].length).round(2)
          season[type][:average_goals_against] = (season[type][:total_goals_against].to_f / season[type].length).round(2)
        end
      end
    end
    return summary
  end
end
