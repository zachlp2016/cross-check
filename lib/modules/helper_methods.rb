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

  def group_by_team_general
    games = Hash.new {|games,team| games[team] = []}
    @games.each do |game|
      games[game.away_team_id] << game
      games[game.home_team_id] << game
    end
    return games
  end

  def team_win_loss_by_season(team_id)
    game_results = group_by_team[team_id]
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
    games = group_by_team_general[team_id]
    outcomes_against = Hash.new{|hash,opponent|
      hash[opponent] = {win: 0, loss: 0}
    }
    locations = ["away", "home"]
    games.each do |game|
      locations.each_index do |i|
        if game.send("#{locations[i]}_team_id") == team_id
          if game.outcome[0..3] == locations[i]
            outcomes_against[game.send("#{locations[(i-1).abs]}_team_id")][:win] += 1
          else
            outcomes_against[game.send("#{locations[(i-1).abs]}_team_id")][:loss] += 1
          end
        end
      end
    end
    return outcomes_against
  end

  def get_team_stats_for_single_season(season_id)
    season_games = @game_teams.select{|game| season_id[0..3] == game.game_id[0..3]}
    team_stats = Hash.new{|team_stats,team_id|
      team_stats[team_id] = Hash.new{|team_id,stat| team_id[stat] = 0}
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
      results[coach] = {total: 0, wins: 0}
    }
    season_games.each do |game|
     if game.won == true
       game_results[game.head_coach][:wins] += 1
     end
     game_results[game.head_coach][:total] += 1
    end
    return game_results
  end

  def group_by_team
    teams = @game_teams.group_by{|game_team| game_team.team_id}
  end

  def total_games_won_by_location(location)
    @game_teams.reduce(0) do |total,team|
      total += 1 if team.home_or_away == location && team.won == true
      total = total
    end
  end

  def total_games
    total_games_won_by_location("home") + total_games_won_by_location("away").to_f
  end

  def seasons
    @games.group_by{|game| game.season}
  end

  def season_win_accumulation(season)
    game_results = Hash.new{|results, team|
      results[team] = Hash.new{|team, season| team[season] = {total: 0, wins: 0}}
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

  def get_win_counts(games)
    counts = {"home_games" => 0.0, "home_wins" => 0.0, "away_games" => 0.0, "away_wins" => 0.0}
    games.each do |game|
      counts["#{game.home_or_away}_games"] += 1
      counts["#{game.home_or_away}_wins"] += 1 if game.won
    end
    return counts
  end

  def goals_allowed(games, team_id)
    games.sum do |game|
      if game.home_team_id == team_id
        game.away_goals
      else
        game.home_goals
      end
    end
  end

  def goals_scored(games, team_id, location)
    games.sum do |game|
      if game.send("#{location}_team_id") == team_id
        game.send("#{location}_goals")
      else
        0
      end
    end
  end
end
