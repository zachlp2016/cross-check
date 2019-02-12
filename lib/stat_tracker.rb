require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data = nil)
    if data
      @games = data[:games].map {|game| @games << game}
      @teams = data[:teams].map{|team| Team.new(team.to_hash)}
      @game_teams = data[:game_teams].map {|game_team| @game_teams << game_team}
    end
  end

  def self.from_csv(files)
    options = {headers: true}
    StatTracker.new({
        games: CSV.open(files[:games], options),
        teams: CSV.open(files[:teams], options),
        game_teams: CSV.open(files[:game_teams], options)
        })
  end
end
