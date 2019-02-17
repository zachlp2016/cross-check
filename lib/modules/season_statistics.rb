module SeasonStatistics
  def most_accurate_team(season_id)
    season_games = @game_teams.select{|game| season_id[0..3] == game.game_id[0..3]}
    team_stats = Hash.new{|team_stats,team_id|
      team_stats[team_id] = {
        goals: 0,
        shots: 0
      }
    }
    season_games.each do |game|
      team_stats[game.team_id][:goals] += game.goals
      team_stats[game.team_id][:shots] += game.shots
    end
    team = team_stats.max_by{|team,stats| stats[:goals].to_f / stats[:shots]}
    return get_team_name(team[0])
  end
end
