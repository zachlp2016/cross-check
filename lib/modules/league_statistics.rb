module LeagueStatistics

  def count_of_teams
    teams.count
  end

  def group_by_team
    teams = @game_teams.group_by do |game_team|
      game_team.team_id
    end
  end

  def group_by_game
    games = @game_teams.group_by do |game_team|
      game_team.game_id
    end
  end

  def best_offense
    max_team_average_by_id = group_by_team.max_by do |team|
      sum_of_team_goals = team[1].sum do |game|
        game.goals
      end
      average_goals_per_game_per_team = (sum_of_team_goals.to_f / team[1].count)
    end
    return decipher_name(max_team_average_by_id[0])
  end

  def worst_offense
    min_team_average_by_id = group_by_team.min_by do |team|
      sum_of_team_goals = team[1].sum do |game|
        game.goals
      end
      average_goals_per_game_per_team = (sum_of_team_goals.to_f / team[1].count)
    end
    return decipher_name(min_team_average_by_id[0])
  end

  def decipher_name(team_id)
    teams.each do |team|
      if team_id == team.team_id
        return team.team_name
      end
    end
  end

  def goals_per_team
    goals_per_team = {}
    group_by_game.each_value do |game_array|
      game_array.each do |game|
        goals_per_team[game.team_id] == nil
          goals_per_team[game.team_id] = 0
      end
    end
    return goals_per_team
  end

  def goals_accumulation
    goals_accumulation = goals_per_team
      group_by_game.each_value do |game_value|
        game_value.each_index do |index|
          if game_value[index].game_id == game_value[0].game_id && index == 0
              goals_accumulation[game_value[0].team_id] += game_value[1].goals
          else game_value[index].game_id == game_value[1].game_id && index == 1
              goals_accumulation[game_value[1].team_id] += game_value[0].goals
          end
        end
      end
    return goals_accumulation
  end

  def games_accumulation
    games_accumulation = {}
      group_by_team.each do |team|
        if games_accumulation[team[0]] == nil
          games_accumulation[team[0]] = 0
        end
      end
      group_by_team.each do |team|
          games_accumulation[team[0]] += team[1].count
      end
    return games_accumulation
  end

  def best_defense
    best_defense = games_accumulation.min_by do |game|
      (goals_accumulation[game[0]].to_f / game[1].to_f).round(2)
    end
    decipher_name(best_defense[0])
  end

  def worst_defense
    worst_defense = games_accumulation.max_by do |game|
      (goals_accumulation[game[0]].to_f / game[1].to_f).round(2)
    end
    decipher_name(worst_defense[0])
  end

  def highest_scoring_visitor
    visitor_goals_accumulation = goals_per_team
      group_by_game.each_value do |game_value|
        game_value.each_index do |index|
          if game_value[index].game_id == game_value[0].game_id && index == 0
              goals_accumulation[game_value[0].team_id] += game_value[0].goals
          end
        end
      end
      highest_scoring_visitor = visitor_goals_accumulation.max_by do |game|
        binding.pry
      end
    return highest_scoring_visitor
  end
end

# def best_defense
#   goals_allowed = {}
#   group_by_game.each do |game_hash|
#     if game_hash[1][0].home_or_away == "home" || game_hash[1][0].home_or_away == "away"
#       if goals_allowed[game_hash[1][0].team_id] == nil
#         goals_allowed[game_hash[1][0].team_id] = game_hash[1][1].goals
#       elsif goals_allowed[game_hash[1][0].team_id] != nil
#         goals_allowed[game_hash[1][0].team_id] += game_hash[1][1].goals
#       end
#     elsif game_hash[1][1].home_or_away == "away" || game_hash[1][1].home_or_away == "home"
#       if goals_allowed[game_hash[1][1].team_id] == nil
#         goals_allowed[game_hash[1][1].team_id] = game_hash[1][0].goals
#       elsif goals_allowed[game_hash[1][1].team_id] != nil
#         goals_allowed[game_hash[1][1].team_id] += game_hash[1][0].goals
#       end
#     end
#   end
#   binding.pry
# end
#
# "2012030221","3","away",FALSE,"OT","John Tortorella",2,35,44,8,3,0,44.8,17,7
# "2012030221","6","home",TRUE,"OT","Claude Julien",4,48,51,6,4,1,55.2,4,5
