require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'
require 'pry'

class StatTrackerTest < Minitest::Test

  def setup
    @empty_stat_tracker = StatTracker.new
    @team_info_arr = [
                    ["team_id","franchiseId","shortName","teamName","abbreviation","link"],
                    ["1","23","New Jersey","Devils","NJD","/api/v1/teams/1"],
                    ["4","16","Philadelphia","Flyers","PHI","/api/v1/teams/4"],
                    ["26","14","Los Angeles","Kings","LAK","/api/v1/teams/26"],
                  ]


    @game_path = './data/game_test.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats_test.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @empty_stat_tracker
  end

  def test_stat_tracker_has_from_csv_method
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_stat_tracker_initializes_attributes
    assert_instance_of Array, @stat_tracker.games
    assert_instance_of Array, @stat_tracker.teams
    assert_instance_of Array, @stat_tracker.game_teams
  end

  def test_stat_tracker_teams_ivar_contains_teams
    assert_instance_of Team, @stat_tracker.teams.sample
  end
end
