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
      game_team.game_id.to_s
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
        return team.short_name
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

  def best_defense
    goals_allowed = {}
    @game_teams.each do |game|
      group_by_game.each_value do |game_value|
        game_value.each_index do |index|
        if game.game_id == game_value[0].game_id && index == 0
          # if goals_allowed[game_value[0].team_id] == nil
            goals_allowed[game_value[0].team_id] = game_value[1].goals
          # elsif goals_allowed[game_value[0].team_id] != nil
            goals_allowed[game_value[0].team_id] += game_value[1].goals
          end
        elsif game.game_id == game_value[0].game_id && index == 1
          elsif goals_allowed[game_value[1].team_id] == nil
            goals_allowed[game_value[1].team_id] = game_value[0].goals
          elsif goals_allowed[game_value[1].team_id] != nil
            goals_allowed[game_value[1].team_id] += game_value[0].goals
          end
        end
      end
    end
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
