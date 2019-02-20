require 'sinatra'
configure do
  set :public_folder, File.dirname(__FILE__) + '/site'
  set :port, 8080
end
require './lib/stat_tracker'

game_path = './data/game.csv'
team_path = './data/team_info.csv'
game_teams_path = './data/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
# require 'pry'
# binding.pry
stat_tracker.get_general_stats

get '/' do
  # File.read(File.join('site', 'index.html'))
  redirect to('/index.html')
end

get '/data/:method' do |method|
  begin
    if params.count > 1
      arg = params["team_id"] || params["season_id"]
      stat_tracker.send(method, arg)
    else
      stat_tracker.send(method)
    end
  rescue StandardError => e
    "#{e.message}, #{e.backtrace.inspect}"
  end
end
