require './lib/stat_tracker'
module GameMethods

  def highest_total_score
    total_score = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    total_score.away_goals + total_score.home_goals
  end

  def lowest_total_score
    total_score = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    total_score.away_goals + total_score.home_goals
  end

  def biggest_blowout
   difference_in_score = @games.max_by do |game|
     game.away_goals - game.home_goals
   end
   difference_in_score.away_goals - difference_in_score.home_goals
 end

 def percentage_home_wins

 end

 def total_home_games_won
   home_wins = @game_teams.map do |team|
    if team.home_or_away == "home" && team.won == true
      team.team_id
      end
    end
    home_wins.compact.count
  end

  def total_away_games_won
   away_wins = @game_teams.map do |team|
    if team.home_or_away == "away" && team.won == true
      team.team_id
      end
    end
    away_wins.compact.count
  end

end
