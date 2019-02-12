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

end
