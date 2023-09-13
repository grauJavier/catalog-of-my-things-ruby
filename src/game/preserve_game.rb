require 'json'

class PreserveGameAlbums
  def gets_game_albums
    return unless File.exist?('./src/game/game_albums.json')

    saved_game_albums = []
    file = File.read('./src/game/game_albums.json')
    data_hashes = JSON.parse(file)
    data_hashes.each do |game_album|
      saved_game_albums << GameAlbum.from_hash(game_album)
    end
    saved_game_albums
  end

  def save_game_albums(game_albums)
    return if game_albums.empty?

    data_hashes = game_albums.map(&:to_hash)
    File.write('./src/game/game_albums.json', JSON.pretty_generate(data_hashes))
  end
end
