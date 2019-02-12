module TeamMethods

  def count_of_teams
    teams.count
  end

  # Get highest Average goals scored per game for a team,
  # then produce the team with the highest average.

  def best_offense
    game_teams.each do |game_team|
      binding.pry
    end
  end
end
