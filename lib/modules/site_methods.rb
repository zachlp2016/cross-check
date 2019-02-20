require 'json'
module SiteMethods
  def get_team_list
    team_list = {}
    @teams.each do |team|
      team_list[team.team_id] = team.team_name
    end
    return team_list.to_json
  end

  def get_season_list
    season_list = {}
    @games.each do |game|
      season_list[game.season] = "#{game.season[0..3]} - #{game.season[4..7]}"
    end
    return season_list.to_json
  end

  def get_team_details(team_id)
    puts "Loading details for team_id #{team_id}..."
    big_time = Time.now
    output = {}
    TeamStatistics.instance_methods.each do |method|
      time = Time.now
      begin
        output[method.to_s] = self.send(method, team_id)
      rescue StandardError => e
        output[method.to_s] = e.message
        output[method.to_s] += e.backtrace.to_s
      end
      puts "  #{method.to_s} took #{Time.now - time} seconds."
    end
    puts "Getting team details took #{Time.now - big_time} seconds."
    return output.to_json
  end

  def get_season_details(season_id)
    puts "Loading details for season_id #{season_id}..."
    big_time = Time.now
    output = {}
    SeasonStatistics.instance_methods.each do |method|
      time = Time.now
      begin
        output[method.to_s] = self.send(method, season_id)
      rescue StandardError => e
        output[method.to_s] = e.message
        output[method.to_s] += e.backtrace.to_s
      end
      puts "  #{method.to_s} took #{Time.now - time} seconds."
    end
    puts "Getting season details took #{Time.now - big_time} seconds."
    return output.to_json
  end

  def load_general_stats
    puts "Loading general stats..."
    big_time = Time.now
    output = {}
    methods = [GameStatistics.instance_methods, LeagueStatistics.instance_methods].flatten
    methods.each do |method|
      time = Time.now
      begin
        output[method.to_s] = self.send(method)
      rescue StandardError => e
        output[method.to_s] = e.message
        output[method.to_s] += e.backtrace.to_s
      end
      puts "  #{method.to_s} took #{Time.now - time} seconds."
    end
    puts "Getting general stats took #{Time.now - big_time} seconds."
    return output.to_json
  end

  def get_general_stats
    @output ||= load_general_stats
  end
end
