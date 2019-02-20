module LeagueHelperMethods

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
    visitor_games_accumulation = {}
      group_by_game.each_value do |game_value|
        if visitor_games_accumulation[game_value[0].team_id] == nil
          visitor_games_accumulation[game_value[0].team_id] = 0
        end
      end
      group_by_game.each_value do |game_value|
        visitor_games_accumulation[game_value[0].team_id] += 1
      end
    return visitor_games_accumulation
  end

  def home_games_accumulation
    home_games_accumulation = {}
      group_by_game.each_value do |game_value|
        if home_games_accumulation[game_value[1].team_id] == nil
          home_games_accumulation[game_value[1].team_id] = 0
        end
      end
      group_by_game.each_value do |game_value|
        home_games_accumulation[game_value[1].team_id] += 1
      end
    return home_games_accumulation
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
end
