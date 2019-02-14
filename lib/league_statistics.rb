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
        return team.short_name
      end
    end
  end

  def best_defense
    goals_allowed_by_team = {}
    group_by_game.each do |game|
      if game[1][0].home_or_away == "home"
        goals_allowed_by_team[game[1][0].team_id] = game[1][1].goals
      elsif game[1][1].home_or_away == "away"
        goals_allowed_by_team[game[1][1].team_id] = game[1][0].goals
      end
    end
    binding.pry
  end
end
