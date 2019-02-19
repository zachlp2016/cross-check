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

  def most_hits(season_id)
    team_stats = get_team_stats_for_single_season(season_id)
    team = team_stats.max_by{|team,stats| stats[:hits]}[0]
    return get_team_name(team)
  end

  def least_hits(season_id)
    team_stats = get_team_stats_for_single_season(season_id)
    team = team_stats.min_by{|team,stats| stats[:hits]}[0]
    return get_team_name(team)
  end

  def power_play_goal_percentage(season_id)
    goals = 0.0
    power_play_goals = 0.0
    @game_teams.each do |game|
      if season_id[0..3] == game.game_id[0..3]
        goals += game.goals
        power_play_goals += game.power_play_goals
      end
    end
    return (power_play_goals / goals).round(2)
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
