require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class GameTeamTest < Minitest::Test
  def setup
    @game_team = GameTeam.new({
      "game_id" => "2012030221",
      "team_id" => "3",
      "HoA" => "away",
      "won" => "FALSE",
      "settled_in" => "OT",
      "head_coach" => "John Tortorella",
      "goals" => "2",
      "shots" => "35",
      "hits" => "44",
      "pim" => "8",
      "powerPlayOpportunities" => "3",
      "powerPlayGoals" => "0",
      "faceOffWinPercentage" => "44.8",
      "giveaways" => "17",
      "takeaways" => "7"})
  end

  def test_team_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_game_team_attributes_initialize_correctly
    assert_equal "2012030221", @game_team.game_id
    assert_equal "3", @game_team.team_id
    assert_equal "away", @game_team.home_or_away
    assert_equal false, @game_team.won
    assert_equal "OT", @game_team.settled_in
    assert_equal "John Tortorella", @game_team.head_coach
    assert_equal 2, @game_team.goals
    assert_equal 35, @game_team.shots
    assert_equal 44, @game_team.hits
    assert_equal 8, @game_team.pim
    assert_equal 3, @game_team.power_play_opportunities
    assert_equal 0, @game_team.power_play_goals
    assert_equal 44.8, @game_team.face_off_win_percentage
    assert_equal 17, @game_team.giveaways
    assert_equal 7, @game_team.takeaways
  end
end
