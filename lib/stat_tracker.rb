require 'csv'

class StatTracker

  def initialize(data)
    @data = data
  end

  def self.from_csv(files)
    options = {headers: true}
    StatTracker.new({
        games: CSV.open(files[:games], options),
        teams: CSV.open(files[:teams], options),
        game_teams: CSV.open(files[:game_teams], options)})
  end
end
