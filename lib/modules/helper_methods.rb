module HelperMethods
  def get_team(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  def get_team_name(team_id)
    teams.each do |team|
      if team_id == team.team_id
        return team.team_name
      end
    end
  end

  def get_team_stats_for_each_game(team_id)
    @game_teams.select {|game| game.team_id == team_id}
  end

  def get_general_game_stats_by_team(team_id)
    @games.select do |game|
      game.home_team_id == team_id ||
      game.away_team_id == team_id
    end
  end

  def team_win_loss_by_season(team_id)
    game_results = get_team_stats_for_each_game(team_id)
    season_results = Hash.new{|hash,key|
      hash[key] = {win: 0, loss: 0}
    }
    game_results.each do |game|
      season = game.game_id.to_s.slice(0..3)
      season += (season.to_i + 1).to_s
      result = game.won ? :win : :loss
      season_results[season][result] += 1
    end
    return season_results
  end

  def get_outcomes_by_opponent(team_id)
    games = get_team_stats_for_each_game(team_id)
    outcomes_against = Hash.new{|hash,opponent|
      hash[opponent] = {win: 0, loss: 0}
    }
    games.each do |target_game|
      opponent = @game_teams.find do |game|
        game.game_id == target_game.game_id &&
        game.team_id != target_game.team_id
      end.team_id
      outcome = target_game.won ? :win : :loss
      outcomes_against[opponent][outcome] += 1
    end
    return outcomes_against
  end

  def get_team_stats_for_single_season(season_id)
    season_games = @game_teams.select{|game| season_id[0..3] == game.game_id[0..3]}
    team_stats = Hash.new{|team_stats,team_id|
      team_stats[team_id] = Hash.new{|team_id,stat|
        team_id[stat] = 0
      }
    }
    season_games.each do |game|
      [:goals, :shots, :hits, :pim,
       :power_play_opportunities, :power_play_goals,
       :face_off_win_percentage, :giveaways, :takeaways].each do |stat|
        team_stats[game.team_id][stat] += game.send(stat)
      end
    end
    return team_stats
  end

  def game_results_by_coach(season)
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
    return game_results
  end
end
