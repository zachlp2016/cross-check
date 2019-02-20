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
    return  get_team_name(max_team_average_by_id[0])
  end

  def worst_offense
    min_team_average_by_id = group_by_team.min_by do |team|
      sum_of_team_goals = team[1].sum do |game|
        game.goals
      end
      average_goals_per_game_per_team = (sum_of_team_goals.to_f / team[1].count)
    end
    return  get_team_name(min_team_average_by_id[0])
  end

  def best_defense
    best_defense = group_by_team_general.min_by do |team_id,games|
      goals_allowed = goals_allowed(games, team_id)
      goals_allowed.to_f / games.count
    end
    get_team_name(best_defense[0])
  end

  def worst_defense
    worst_defense = group_by_team_general.max_by do |team_id,games|
      goals_allowed = goals_allowed(games, team_id)
      goals_allowed.to_f / games.count
    end
    get_team_name(worst_defense[0])
  end

  def highest_scoring_visitor
    highest_scoring_visitor = group_by_team_general.max_by do |team_id,games|
      goals_scored = goals_scored(games, team_id, "away")
      goals_scored.to_f / games.count
    end
    return  get_team_name(highest_scoring_visitor[0])
  end

  def highest_scoring_home_team
    highest_scoring_home = group_by_team_general.max_by do |team_id,games|
      goals_scored = goals_scored(games, team_id, "home")
      goals_scored.to_f / games.count
      end
    return  get_team_name(highest_scoring_home[0])
  end

  def lowest_scoring_visitor
    highest_scoring_visitor = group_by_team_general.min_by do |team_id,games|
      goals_scored = goals_scored(games, team_id, "away")
      goals_scored.to_f / games.count
    end
    return  get_team_name(highest_scoring_visitor[0])
  end

  def lowest_scoring_home_team
    highest_scoring_home = group_by_team_general.min_by do |team_id,games|
      goals_scored = goals_scored(games, team_id, "home")
      goals_scored.to_f / games.count
      end
    return  get_team_name(highest_scoring_home[0])
  end

  def winningest_team
    best_win_percentage = group_by_team.max_by do |team_id,games|
      wins = games.sum do |game|
        if game.won
          1
        else
          0
        end
      end
      wins.to_f / games.count
    end
    return  get_team_name(best_win_percentage[0])
  end

  def best_fans
    best_fans = group_by_team.max_by do |team_id,games|
      counts = get_win_counts(games)
      (counts["home_wins"] / counts["home_games"] -
       counts["away_wins"] / counts["away_games"])
    end
    return get_team_name(best_fans[0])
  end

  def worst_fans
    worst_fans = []
    group_by_team.each do |team_id,games|
      counts = get_win_counts(games)
      if  (counts["home_wins"] / counts["home_games"]) <
          (counts["away_wins"] / counts["away_games"])
        worst_fans << get_team_name(team_id)
      end
    end
    return worst_fans
  end
end
