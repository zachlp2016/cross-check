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

  def biggest_bust(season)
    biggest_bust = season_win_accumulation(season).max_by do |team_id,stats|
      if stats.has_key?("03") && stats.has_key?("02")
        stats["03"][:wins].to_f / stats["03"][:total] -
        stats["02"][:wins].to_f / stats["02"][:total]
      else
        # we never encounter this in our test data,
        # but it's necessary for the full dataset
        0.0
      end
    end
    return get_team_name(biggest_bust[0])
  end

  def biggest_surprise(season)
    biggest_surprise = season_win_accumulation(season).max_by do |team_id,stats|
      if stats.has_key?("03") && stats.has_key?("02")
        stats["02"][:wins].to_f / stats["02"][:total] -
        stats["03"][:wins].to_f / stats["03"][:total]
      else
        # we never encounter this in our test data,
        # but it's necessary for the full dataset
        0.0
      end
    end
    return get_team_name(biggest_surprise[0])
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
      coach[:wins].to_f / coach[:total].to_f
    end
    the_coach[0]
  end

  def winningest_coach(season)
    the_coach = game_results_by_coach(season).max_by do |game, coach|
      coach[:wins].to_f / coach[:total].to_f
    end
    the_coach[0]
  end
end
