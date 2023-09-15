require 'json'

class PreserveMusicAlbums
  def gets_music_albums
    return [] unless File.exist?('./src/music_album/music_albums.json')

    saved_music_albums = []
    file = File.read('./src/music_album/music_albums.json')
    return [] if file.empty?

    data_hashes = JSON.parse(file)
    data_hashes.each do |music_album|
      saved_music_albums << MusicAlbum.from_hash(music_album)
    end
    saved_music_albums
  end

  def save_music_albums(music_albums)
    return if music_albums.empty?

    data_hashes = music_albums.map(&:to_hash)
    File.write('./src/music_album/music_albums.json', JSON.pretty_generate(data_hashes))
  end
end
