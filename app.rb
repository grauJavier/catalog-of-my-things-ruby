require_relative 'javier/music_album'
require_relative 'javier/preserve_music_albums'

class App
  attr_accessor :music_albums

  def initialize
    @music_albums = PreserveMusicAlbums.new.gets_music_albums || []
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts "\nNo albums yet"
    else
      puts "\nAlbums:"
      @music_albums.each_with_index do |music_album, index|
        output = "#{index}: '#{music_album.title}' "

        output += if music_album.published_date != 0
                    "Published on #{music_album.published_date} | "
                  else
                    "Published date 'Unknown' | "
                  end

        output += if music_album.on_spotify == 'true'
                    'On Spotify: YES'
                  else
                    'On Spotify: NO'
                  end
        puts output
      end
    end
  end

  def add_a_music_album
    print 'Title: '
    title = gets.chomp

    print 'Publish Date (YEAR): '
    publish_date = gets.chomp

    if publish_date.match?(/\A\d+\z/)
      publish_date = publish_date.to_i
    else
      puts "ERROR: Invalid answer. Value set to 'Unkown'"
      publish_date = 'Unknown'
    end

    print 'Available on Spotify (Y/N): '
    on_spotify = gets.chomp.downcase

    if on_spotify == 'y'
      on_spotify = true
    elsif on_spotify == 'n'
      on_spotify = false
    else
      puts "ERROR: Invalid answer. Value set to 'N'"
      on_spotify = false
    end

    @music_albums.push(MusicAlbum.new(title, publish_date, on_spotify))
    puts 'Music Album added successfully!'
  end

  def quit
    PreserveMusicAlbums.new.save_music_albums(@music_albums)
    puts 'Thank you for using this app!'
    exit
  end
end
