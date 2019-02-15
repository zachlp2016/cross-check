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
    home_percentage =  total_home_games_won/total_games
    return home_percentage.round(2)
  end

  def percentage_away_wins
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

  def total_count_of_games_by_season(season)
    seasons[season].count
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
      game.home_goals + game.away_goals
    end
    (total_goals.to_f/total_games).round(2)
  end

  def average_goals_by_season(season_years)
    total_season_goals = @games.map do |game|
      if game.season == season_years
      game.home_goals + game.away_goals
      end
    end.compact.sum

    (total_season_goals.to_f/total_count_of_games_by_season(season_years)).round(2)
  end

  def seasons
    @games.group_by do |season|
      season.season
    end
  end
end
