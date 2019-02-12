require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker.rb'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test

  def setup
    # @files = {
    #   games: './data/game.csv',
    #   teams: './data/team_info.csv',
    #   game_teams: './data/game_teams_stats.csv'
    # }
    #
    # @stat_tracker = StatTracker.new
    # @files_from_csv = StatTracker.from_csv(@files)
    # @games = Game.new(@stat_tracker.games)

    @game_data = {
          game_id: "2012030221",
          season: "20122013",
          type: "P",
          date_time: 2013-05-16,
          away_team_id: "3",
          home_team_id: "6",
          away_goals: 2,
          home_goals: 3,
          outcome: "home win OT",
          home_rink_side_start: "left",
          venue: "TD Garden",
          venue_link: "/api/v1/venues/null",
          venue_time_zone_id: "America/New_York",
          venue_time_zone_offset: -4,
          venue_time_zone_tz: "EDT"
        }

    @game = Game.new(@game_data)
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end

  def test_games_hold_game_data
    assert_equal @game_data, @game.data
  end

end
