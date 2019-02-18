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
    season_games = @game_teams.select{|game| season_id[0..3] == game.game_id[0..3]}
    game_results = Hash.new{|results, coach|
      results[coach] = {
        total: 0,
        wins: 0
      }
    }
    binding.pry
    season_games.each do |game|
      game_results[game.head_coach][:total] += 1
      game_results[game.head_coach][:win] += 1
    end
  end
end
