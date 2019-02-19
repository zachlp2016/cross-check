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
      (game.home_goals - game.away_goals).abs #abs returns absolute value so negitve numbers become postive
    end
    (difference_in_score.home_goals - difference_in_score.away_goals).abs
  end

  def percentage_home_wins
    home_percentage =  total_home_games_won/total_games
    return home_percentage.round(2)
  end

  def percentage_visitor_wins
    away_percentage =  total_away_games_won/total_games
    return away_percentage.round(2)
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

  def total_games
    total_home_games_won + total_away_games_won.to_f
  end

  def count_of_games_by_season
    output_by_game = {}
    seasons.each do |season, game|
      output_by_game[season] = game.count
    end
    output_by_game
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
      game.home_goals + game.away_goals
    end
    (total_goals.to_f/total_games).round(2)
  end

  def average_goals_by_season
    output_by_average_goals = {}
    seasons.each do |season, season_game|
      season_goals = season_game.sum do |game|
        game.home_goals + game.away_goals
      end.to_f
      output_by_average_goals[season] = (season_goals/season_game.count).round(2)
    end
    output_by_average_goals
  end

  def seasons
    @games.group_by do |season|
      season.season
    end
  end
end
