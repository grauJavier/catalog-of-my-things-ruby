require 'json'

class PreserveMusicAlbums
  def gets_music_albums
    return unless File.exist?('./music_albums.json')

    saved_music_albums = []
    file = File.read('./music_albums.json')
    data_hash = JSON.parse(file)
    data_hash.each do |music_album|
      saved_music_albums << MusicAlbum.new(music_album['genre'], music_album['author'], music_album['source'],
                                           music_album['label'], music_album['publish_date'], music_album['on_spotify'])
    end
    saved_music_albums
  end

  def save_music_albums(music_albums)
    return if music_albums.empty?

    data_hash = []
    music_albums.each_with_index do |music_album, _index|
      data_hash << { genre: { genre_name: music_album.genre.genre_name },
                     author: {
                       first_name: music_album.author.first_name,
                       last_name: music_album.author.last_name
                     },
                     source: { source_name: music_album.source.source_name },
                     label: {
                       title: music_album.label.title,
                       color: music_album.label.color
                     },
                     publish_date: music_album.publish_date,
                     on_spotify: music_album.on_spotify }
    end
    File.write('./music_albums.json', JSON.pretty_generate(data_hash))
  end
end
