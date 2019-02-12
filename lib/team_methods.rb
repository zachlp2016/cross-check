module TeamMethods

  def count_of_teams
    teams.count
  end

  # Get highest Average goals scored per game for a team,
  # then produce the team with the highest average.

  def group_by_team
    teams = @game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def team_id_best_offense
    max_team_average_by_id = group_by_team.max_by do |team|
      sum_of_team_goals = team[1].sum do |game|
        game.goals
      end
      average_goals_per_game_per_team = (sum_of_team_goals.to_f / team[1].count)
      return team[0]
    end
  end

  def best_offense
    teams.each do |team|
      if team_id_best_offense == team.team_id
        return team.short_name
      end
    end
  end
end
