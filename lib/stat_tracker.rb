require 'csv'
require './lib/true_false_converter'
require './lib/team_methods'


class StatTracker
  include TrueFalseConverter
  include TeamMethods
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data = nil)
    if data
      @games = data[:games].map {|game| Game.new(game.to_hash)}
      @teams = data[:teams].map{|team| Team.new(team.to_hash)}
      @game_teams = data[:game_teams].map {|game_team| GameTeam.new(game_team.to_hash)}
    end
  end

  def self.from_csv(files)
    options = {headers: true, converters: [:numeric, :true_false_string_to_bool]}
    StatTracker.new({
        games: CSV.open(files[:games], options),
        teams: CSV.open(files[:teams], options),
        game_teams: CSV.open(files[:game_teams], options)
        })
  end
end
