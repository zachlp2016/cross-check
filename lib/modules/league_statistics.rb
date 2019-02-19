module LeagueStatistics
  def count_of_teams
    teams.count
  end

  def group_by_team
    teams = @game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def group_by_game
    games = @game_teams.group_by do |game_team|
      game_team.game_id
    end
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

  def decipher_name(team_id)
    teams.each do |team|
      if team_id == team.team_id
        return team.team_name
      end
    end
  end

  def goals_per_team
    goals_per_team = {}
    group_by_game.each_value do |game_array|
      game_array.each do |game|
        goals_per_team[game.team_id] == nil
          goals_per_team[game.team_id] = 0
      end
    end
    return goals_per_team
  end

  def goals_accumulation
    goals_accumulation = goals_per_team
      group_by_game.each_value do |game_value|
        game_value.each_index do |index|
          if game_value[index].game_id == game_value[0].game_id && index == 0
              goals_accumulation[game_value[0].team_id] += game_value[1].goals
          else game_value[index].game_id == game_value[1].game_id && index == 1
              goals_accumulation[game_value[1].team_id] += game_value[0].goals
          end
        end
      end
    return goals_accumulation
  end

  def games_accumulation
    games_accumulation = {}
      group_by_team.each do |team|
        if games_accumulation[team[0]] == nil
          games_accumulation[team[0]] = 0
        end
      end
      group_by_team.each do |team|
          games_accumulation[team[0]] += team[1].count
      end
    return games_accumulation
  end

  def visitor_games_accumulation
    games_accumulation = {}
      group_by_game.each_value do |game_value|
        if games_accumulation[game_value[0].team_id] == nil
          games_accumulation[game_value[0].team_id] = 0
        end
      end
      group_by_game.each_value do |game_value|
        games_accumulation[game_value[0].team_id] += 1
      end
    return games_accumulation
  end

  def home_games_accumulation
    games_accumulation = {}
      group_by_game.each_value do |game_value|
        if games_accumulation[game_value[1].team_id] == nil
          games_accumulation[game_value[1].team_id] = 0
        end
      end
      group_by_game.each_value do |game_value|
        games_accumulation[game_value[1].team_id] += 1
      end
    return games_accumulation
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

  def visitor_goals_accumulation
    visitor_goals_accumulation = goals_per_team
    group_by_game.each_value do |game_value|
            visitor_goals_accumulation[game_value[0].team_id] += game_value[0].goals
    end
    return visitor_goals_accumulation
  end

  def home_goals_accumulation
    home_goals_accumulation = goals_per_team
    group_by_game.each_value do |game_value|
            home_goals_accumulation[game_value[1].team_id] += game_value[1].goals
    end
    return home_goals_accumulation
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

  def wins_accumulation
    win_accumulator = goals_per_team
    group_by_team.each do |team|
      team[1].each do |game|
        if game.won == true
        win_accumulator[team[0]] += 1
        end
      end
    end
    return win_accumulator
  end

  def winningest_team
    best_win_percentage = wins_accumulation.max_by do |team|
      (team[1].to_f / games_accumulation[team[0].to_s].to_f).round(2)
    end
    return decipher_name(best_win_percentage[0])
  end

  def home_wins_accumulation
    home_win_accumulator = goals_per_team
    group_by_game.each_value do |game_value|
      if game_value[1].won == true
            home_win_accumulator[game_value[1].team_id] += 1
      end
    end
    return home_win_accumulator
  end

  def away_wins_accumulation
    away_win_accumulator = goals_per_team
    group_by_game.each_value do |game_value|
      if game_value[0].won == true
            away_win_accumulator[game_value[0].team_id] += 1
      end
    end
    return away_win_accumulator
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
