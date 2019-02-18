module SeasonStatistics
  def most_accurate_team(season_id)
    team_stats = get_team_stats_for_single_season(season_id)
    team = team_stats.max_by{|team,stats| stats[:goals].to_f / stats[:shots]}[0]
    return get_team_name(team)
  end

  def least_accurate_team(season_id)
    team_stats = get_team_stats_for_single_season(season_id)
    team = team_stats.min_by{|team,stats| stats[:goals].to_f / stats[:shots]}[0]
    return get_team_name(team)
  end
  def worst_coach(season)
    season_games = @game_teams.select{|game| season[0..3] == game.game_id[0..3]}
    game_results = Hash.new{|results, coach|
      results[coach] = {
        total: 0,
        wins: 0
      }
    }
    season_games.each do |game|
     if game.won == true
       game_results[game.head_coach][:wins] += 1
     end
     game_results[game.head_coach][:total] += 1
    end

    the_coach = game_results.min_by do |game, coach|
      (coach[:wins].to_f / coach[:total].to_f).round(2)
    end
    the_coach[0]
  end
end
