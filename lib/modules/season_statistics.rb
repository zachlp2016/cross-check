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
    the_coach = game_results_by_coach(season).min_by do |game, coach|
      (coach[:wins].to_f / coach[:total].to_f).round(2)
    end
    the_coach[0]
  end

  def winningest_coach(season)
    the_coach = game_results_by_coach(season).max_by do |game, coach|
      (coach[:wins].to_f / coach[:total].to_f).round(2)
    end
    the_coach[0]
  end
end
