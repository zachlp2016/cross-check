require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.new(nil)
    @team_info_arr = [
                    ["team_id","franchiseId","shortName","teamName","abbreviation","link"],
                    ["1","23","New Jersey","Devils","NJD","/api/v1/teams/1"],
                    ["4","16","Philadelphia","Flyers","PHI","/api/v1/teams/4"],
                    ["26","14","Los Angeles","Kings","LAK","/api/v1/teams/26"],
                  ]


    @game_path = './data/game.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
  }
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_stat_tracker_has_from_csv_method
    assert_instance_of StatTracker, StatTracker.from_csv(@locations)
  end
end
