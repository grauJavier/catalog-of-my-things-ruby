require 'json'

class PreserveGames
  def gets_games
    return unless File.exist?('./src/game/games.json')

    saved_games = []
    file = File.read('./src/game/games.json')
    data_hashes = JSON.parse(file)
    data_hashes.each do |game|
      saved_games << Game.from_hash(game)
    end
    saved_games
  end

  def save_games(games)
    return if games.empty?

    data_hashes = games.map(&:to_hash)
    File.write('./src/game/games.json', JSON.pretty_generate(data_hashes))
  end
end
