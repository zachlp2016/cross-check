require 'csv'
require_relative './data_structures/game'
require_relative './data_structures/team'
require_relative './data_structures/game_team'
require_relative './modules/true_false_converter'
require_relative './modules/team_statistics'
require_relative './modules/league_helper_methods'
require_relative './modules/league_statistics'
require_relative './modules/game_methods'
require_relative './modules/season_statistics'
require_relative './modules/helper_methods'


class StatTracker
  include TrueFalseConverter
  include HelperMethods
  include TeamStatistics
  include LeagueHelperMethods
  include LeagueStatistics
  include GameMethods
  include SeasonStatistics

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
    options = {headers: true, converters: [:true_false_string_to_bool]}
    StatTracker.new({
        games: CSV.open(files[:games], options),
        teams: CSV.open(files[:teams], options),
        game_teams: CSV.open(files[:game_teams], options)
        })
  end
end
