require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'
require 'pry'

class TeamTest < Minitest::Test
  def setup
    @files = {
      games: './data/game_test.csv',
      teams: './data/team_info.csv',
      game_teams: './data/game_teams_stats_test.csv'
    }
    @stat_tracker = StatTracker.from_csv(@files)
  end

  def test_team_exists
    assert_instance_of Team, @stat_tracker.teams[0]
  end
end
