require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class SeasonStatisticsTest < Minitest::Test

  def setup
    @game_path = './test/data/game_test.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './test/data/game_teams_stats_test.csv'
    @biggest_bust_path = './test/data/game_teams_season_biggest_bust.csv'
    @biggest_surprise_large_path = './data/game_teams_stats.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @locations_test_biggest_bust = {
      games: @game_path,
      teams: @team_path,
      game_teams: @biggest_bust_path
    }

    @locations_large_path = {
      games: @game_path,
      teams: @team_path,
      game_teams: @biggest_surprise_large_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
    @stat_tracker_biggest_bust = StatTracker.from_csv(@locations_test_biggest_bust)
    @stat_tracker_large_path = StatTracker.from_csv(@locations_large_path)
  end

  def test_getting_most_accurate_team
    assert_equal "Penguins", @stat_tracker.most_accurate_team("20122013")
  end

  def test_getting_least_accurate_team
    assert_equal "Canadiens", @stat_tracker.least_accurate_team("20122013")
  end

  def test_season_win_accumulation_works
    hash =  {"3"=>{"03"=>{:total=>5, :wins=>1},"02"=>{:total=>5, :wins=>4}},
             "6"=>{"03"=>{:total=>7, :wins=>6},"02"=>{:total=>7, :wins=>2}},
             "5"=>{"03"=>{:total=>2, :wins=>0},"02"=>{:total=>2, :wins=>1}}
            }

    assert_equal hash, @stat_tracker_biggest_bust.season_win_accumulation("20122013")
  end

  def test_preseason_win_perc_house_works
    hash = {"3"=>0.2,
            "6"=>0.86,
            "5"=>0.0
            }
    assert_equal hash, @stat_tracker_biggest_bust.preseason_win_perc("20122013")
  end

  def test_regular_win_perc_hash_works
    hash = {"3"=>0.8,
            "6"=>0.29,
            "5"=>0.5
            }
    assert_equal hash, @stat_tracker_biggest_bust.regular_win_perc("20122013")
  end

  def test_biggest_bust
    assert_equal "Bruins", @stat_tracker_biggest_bust.biggest_bust("20122013")
  end

  def test_biggest_surprise
    assert_equal "Rangers", @stat_tracker_biggest_bust.biggest_surprise("20122013")
  end
  
  def test_getting_most_hits
    assert_equal "Bruins", @stat_tracker.most_hits("20122013")
  end

  def test_getting_least_hits
    assert_equal "Canucks", @stat_tracker.least_hits("20122013")
  end

  def test_getting_power_play_goal_percentage
    assert_equal 0.22, @stat_tracker.power_play_goal_percentage("20122013")
  end

  def test_worst_coach
    assert_equal "Jon Cooper", @stat_tracker.worst_coach("20132014")
    assert_equal "Paul Maurice", @stat_tracker.worst_coach("20142015")
    assert_equal "Randy Carlyle", @stat_tracker.worst_coach("20172018")
  end

  def test_winningest_coach
    assert_equal "Darryl Sutter", @stat_tracker.winningest_coach("20132014")
    assert_equal "Joel Quenneville", @stat_tracker.winningest_coach("20142015")
    assert_equal "Barry Trotz", @stat_tracker.winningest_coach("20172018")
  end
end
