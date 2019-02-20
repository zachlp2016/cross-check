module LeagueStatistics

  def count_of_teams
    teams.count
  end

  def best_offense
    max_team_average_by_id = group_by_team.max_by do |team|
      sum_of_team_goals = team[1].sum do |game|
        game.goals
      end
      average_goals_per_game_per_team = (sum_of_team_goals.to_f / team[1].count)
    end
    return decipher_name(max_team_average_by_id[0])
  end

  def worst_offense
    min_team_average_by_id = group_by_team.min_by do |team|
      sum_of_team_goals = team[1].sum do |game|
        game.goals
      end
      average_goals_per_game_per_team = (sum_of_team_goals.to_f / team[1].count)
    end
    return decipher_name(min_team_average_by_id[0])
  end

  def best_defense
    best_defense = games_accumulation.min_by do |game|
      (goals_accumulation[game[0]].to_f / game[1].to_f).round(2)
    end
    decipher_name(best_defense[0])
  end

  def worst_defense
    worst_defense = games_accumulation.max_by do |game|
      (goals_accumulation[game[0]].to_f / game[1].to_f).round(2)
    end
    decipher_name(worst_defense[0])
  end

  def highest_scoring_visitor
    highest_scoring_visitor = visitor_games_accumulation.max_by do |game|
        (visitor_goals_accumulation[game[0]].to_f / game[1].to_f).round(2)
    end
    return decipher_name(highest_scoring_visitor[0])
  end

  def highest_scoring_home_team
    highest_scoring_home = home_games_accumulation.max_by do |game|
        (home_goals_accumulation[game[0]].to_f / game[1].to_f).round(2)
      end
    return decipher_name(highest_scoring_home[0])
  end

  def lowest_scoring_visitor
    highest_scoring_visitor = visitor_games_accumulation.min_by do |game|
        (visitor_goals_accumulation[game[0]].to_f / game[1].to_f).round(2)
    end
    return decipher_name(highest_scoring_visitor[0])
  end

  def lowest_scoring_home_team
    highest_scoring_home = home_games_accumulation.min_by do |game|
        (home_goals_accumulation[game[0]].to_f / game[1].to_f).round(2)
      end
    return decipher_name(highest_scoring_home[0])
  end

  def winningest_team
    best_win_percentage = wins_accumulation.max_by do |team|
      (team[1].to_f / games_accumulation[team[0].to_s].to_f).round(2)
    end
    return decipher_name(best_win_percentage[0])
  end

  def best_fans
    best_fans = group_by_team.max_by do |team|
      (home_wins_accumulation[team[0]].to_f / home_games_accumulation[team[0]]).to_f - (away_wins_accumulation[team[0]].to_f / visitor_games_accumulation[team[0]].to_f)
    end
    return decipher_name(best_fans[0])
  end

  def worst_fans
    worst_fans = []
    group_by_team.each do |team|
      if  (home_wins_accumulation[team[0]].to_f / home_games_accumulation[team[0]].to_f) < (away_wins_accumulation[team[0]].to_f / visitor_games_accumulation[team[0]].to_f)
        worst_fans << team[0]
      end
    end
    return worst_fans
  end
end
