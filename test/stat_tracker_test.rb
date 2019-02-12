require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'
require './lib/game_team'
require 'pry'

class StatTrackerTest < Minitest::Test

  def setup
    @empty_stat_tracker = StatTracker.new

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

  def test_stat_tracker_teams_ivars_contain_correct_types
    assert_instance_of Game, @stat_tracker.games.sample
    assert_instance_of Team, @stat_tracker.teams.sample
    assert_instance_of GameTeam, @stat_tracker.game_teams.sample
  end

  def test_game_team_data_converts_true_false_strings_to_booleans
    assert_equal false, @stat_tracker.game_teams[0].won
    assert_equal true, @stat_tracker.game_teams[1].won
  end
end
