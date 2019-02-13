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
    seasons = @games.group_by do |season|
      season.season
    end
      seasons.fetch_values(season)[0].count
  end

  def average_goals_per_game

  end

end
