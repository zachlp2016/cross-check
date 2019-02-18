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

  # def preseason_accumulator
  #   game_seasons = {}
  #   @games.each do |game|
  #
  #   end
  #   binding.pry
  # end

  # def pre_season_hash
  #     game_results = Hash.new{|results, game_team.team_id|
  #       results[game_team.team_id] = Hash.new{|game_team.team_id, season|
  #         game_team.team_id[season] = {total: 0, wins: 0}
  #       }
  #     }
  # end
# end

  def season_win_accumulation(season)
    game_results = Hash.new{|results, team|
      results[team] = Hash.new{|team, season|
        team[season] = {total: 0, wins: 0}
      }
    }
    @game_teams.each do |game|
      if game.game_id[0..3] == season[0..3]
        if game.won == true
          game_results[game.team_id][game.game_id[4..5]][:wins] += 1
        end
        game_results[game.team_id][game.game_id[4..5]][:total] += 1
      end
    end
    return game_results
  end

  def preseason_win_perc(season)
    preseason_win = Hash.new{|team, preseason_win|
      preseason_win[team] = 0
    }
    season_win_accumulation(season).each do |team|
      preseason_win[team[0]] = (team[1]["03"][:wins].to_f / team[1]["03"][:total].to_f).round(2)
    end
    return preseason_win
  end

  def regular_win_perc(season)
  regular_season = Hash.new{|team, regular_season|
    regular_season[team] = 0
  }
    season_win_accumulation(season).each do |team|
      regular_season[team[0]] = (team[1]["02"][:wins].to_f / team[1]["02"][:total].to_f).round(2)
    end
    binding.pry
    return regular_season
  end

  #Name of the team with the biggest decrease between
  #preseason and regular season win percentage.

  def biggest_bust(season)
    biggest_bust = preseason_win_perc(season).max_by do |team|
      (team[1].to_f / regular_win_perc(season)[team[0]].to_f).round(2)
    end
    return get_team_name(biggest_bust[0])
  end

  def biggest_surprise(season)
    biggest_surprise = preseason_win_perc(season).min_by do |team|
      (team[1].to_f / regular_win_perc(season)[team[0]].to_f).round(2)
    end
    return get_team_name(biggest_surprise[0])
  end

end
