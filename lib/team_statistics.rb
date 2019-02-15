module TeamStatistics
  def team_info(team_id)
    get_team(team_id).info
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
    games = get_team_stats_for_each_game(team_id)
    wins = games.count{|game| game.won}
    (wins.to_f / games.count).round(4) * 100
  end

  def most_goals_scored(team_id)
    games = get_team_stats_for_each_game(team_id)
    games.max_by{|game| game.goals}.goals
  end

  def fewest_goals_scored(team_id)
    games = get_team_stats_for_each_game(team_id)
    games.min_by{|game| game.goals}.goals
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
      summary[season] = Hash.new{|season,type|
        season[type] = Hash.new{|type,stat|
          type[stat] = 0
        }
      }
    }
    counter = Hash.new{|counter,season|
      counter[season] = Hash.new{|season,type|
        season[type] = {total: 0.0, wins: 0.0}
      }
    }
    get_general_game_stats_by_team(team_id).each do |game|
      type = game.type == "P" ? :playoffs : :regular_season
      location = game.home_team_id == team_id ? ["home", "away"] : ["away", "home"]
      summary[game.season][type][:total_goals_scored] += game.send("#{location[0]}_goals")
      summary[game.season][type][:total_goals_against] += game.send("#{location[1]}_goals")
      counter[game.season][type][:wins] += 1 if game.send("#{location[0]}_goals") > game.send("#{location[1]}_goals")
      counter[game.season][type][:total] += 1
    end
    summary.each do |season,details|
      [:playoffs,:regular_season].each do |type|
        if details.has_key?(type)
          details[type][:win_percentage] = (counter[season][type][:wins].to_f / counter[season][type][:total]).round(2)
          details[type][:average_goals_scored] = (details[type][:total_goals_scored].to_f / counter[season][type][:total]).round(2)
          details[type][:average_goals_against] = (details[type][:total_goals_against].to_f / counter[season][type][:total]).round(2)
        end
      end
    end
    return summary
  end
end
