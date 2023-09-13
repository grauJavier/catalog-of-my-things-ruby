require_relative 'src/author'

require_relative 'src/genre'

require_relative 'src/label'

require_relative 'src/source'

require_relative 'src/item'



require_relative 'src/music_album/music_album'

require_relative 'src/music_album/preserve_music_albums'

require_relative 'src/preserve_genres'

require_relative 'src/game/game'

require_relative 'src/game/preserve_game'

# ./src/game/game_albums.json

require_relative 'helper'

# rubocop:disable Metrics/ClassLength



class App
  attr_accessor :music_albums



  def initialize
    @music_albums = PreserveMusicAlbums.new.gets_music_albums || []

    @genres = PreserveGenres.new.gets_genres || []

    @movie = PreserveMovies.new.gets_movies || []

    @games = PreserveGames.new.gets_games || []
  end

  def add_genre
    print 'Genre: '

    genre_name = gets.chomp



    @genre = Genre.new(genre_name)



    return if @genres.any? { |genre| genre.genre_name == genre_name }



    @genres << @genre
  end

  def add_author(item)
    if item == 'music_album'

      print 'Artist: '

      first_name = gets.chomp

      @author = Author.new(first_name, '')

    else

      print 'Author First Name: '

      first_name = gets.chomp



      print 'Author Last Name: '

      last_name = gets.chomp



      @author = Author.new(first_name, last_name)

    end
  end

  def add_source
    print 'Source: '

    source_name = gets.chomp



    @source = Source.new(source_name)
  end

  def add_label
    print 'Title: '

    title = gets.chomp



    print 'Color: '

    color = gets.chomp



    @label = Label.new(title, color)
  end

  def list_all_music_albums
    if @music_albums.empty?

      puts "\nNo albums yet"

    else

      puts "\nAlbums:"

      @music_albums.each_with_index do |music_album, index|
        title = music_album.label.title

        artist = music_album.author.first_name

        genre = music_album.genre.genre_name



        output = "#{index}: TITLE: #{title} | ARTIST: #{artist} | GENRE: #{genre} | "

        output += if music_album.publish_date.zero?

                    "RELEASE DATE: 'Unknown' | "

                  else

                    "RELEASE DATE: #{music_album.publish_date} | "

                  end



        output += if music_album.on_spotify == true

                    'ON SPOTIFY: Yes'

                  else

                    'ON SPOTIFY: No'

                  end

        puts output
      end

    end
  end

  def list_all_movies
    if @movie.empty?

      puts "\nNo movies yet"

    else

      puts "\nMovies:"

      @movie.each_with_index do |movie, index|
        title = movie.label.title

        artist = movie.author.first_name

        genre = movie.genre.genre_name



        output = "#{index}: TITLE: #{title} | ARTIST: #{artist} | GENRE: #{genre} | "

        output += if movie.publish_date.zero?

                    "RELEASE DATE: 'Unknown' | "

                  else

                    "RELEASE DATE: #{movie.publish_date} | "

                  end



        output += if movie.silet == true

                    'SILET: Yes'

                  else

                    'SILET: No'

                  end

        puts output
      end

    end
  end

  def add_a_movie
    add_genre

    add_author('movie')

    add_source

    add_label



    print 'Publish Date (YEAR): '

    publish_date = gets.chomp



    if publish_date.match?(/\A\d+\z/)

      publish_date = publish_date.to_i

    else

      puts "ERROR: Invalid answer. Value set to 'Unkown'"

      publish_date = 0

    end



    print 'Can be Archived (Y/N): '

    silet = gets.chomp.downcase



    if silet == 'y'

      silet = true

    elsif silet == 'n'

      silet = false

    else

      puts "ERROR: Invalid answer. Value set to 'N'"

      silet = false

    end



    @movie.push(Movie.new(@genre, @author, @source, @label, publish_date, silet))

    puts 'Movie added successfully!'
  end

  def add_a_game
    add_genre

    add_author('game')

    add_source

    add_label



    print 'Publish Date (YEAR): '

    publish_date = gets.chomp



    if publish_date.match?(/\A\d+\z/)

      publish_date = publish_date.to_i

    else

      puts "ERROR: Invalid answer. Value set to 'Unkown'"

      publish_date = 0

    end



    print 'Is it multiplayer (Y/N): '

    multiplayer = gets.chomp.downcase



    if multiplayer == 'y'

      multiplayer = true

    elsif multiplayer == 'n'

      multiplayer = false

    else

      puts "ERROR: Invalid answer. Value set to 'N'"

      multiplayer = false

    end


    print 'When was the last time played: '

    last_played_at = gets.chomp.downcase


    @games.push(Game.new(@genre, @author, @source, @label, publish_date, multiplayer, last_played_at))

    puts 'Game added successfully!'
  end

  def list_all_games
    if @games.empty?
      puts "\nNo games yet"
    else
      puts "\nGames:"
      @games.each_with_index do |game, index|
        title = game.label.title
        author = "#{game.author.first_name[0].capitalize}. #{game.author.last_name}"
        multiplayer = game.multiplayer
        last_played_at = game.last_played_at
        release_date = if game.publish_date.zero?
                         'Unknown'
                       else
                         game.publish_date
                       end

        output = "#{index}: TITLE: #{title} | AUTHOR: #{author} | MULTIPLAYER: #{multiplayer}
        |  LAST PLAYED AT: #{last_played_at} | RELEASE DATE: #{release_date}"

        puts output
      end
    end
  end

  def list_all_sources
    if @movie.empty?

      puts "\nNo movie sources yet"

    else

      puts "\nMovie Sources:"



      movie_sources = @movie.map { |movie| movie.source.source_name }

      unique_movie_sources = movie_sources.uniq

      unique_movie_sources.each_with_index do |source_name, index|
        puts "#{index + 1}: #{source_name}"
      end

    end
  end

  def add_a_music_album
    add_genre

    add_author('music_album')

    add_source

    add_label

    print 'Publish Date (YEAR): '

    publish_date = gets.chomp



    if publish_date.match?(/\A\d+\z/)

      publish_date = publish_date.to_i

    else

      puts "ERROR: Invalid answer. Value set to 'Unkown'"

      publish_date = 0

    end



    print 'Can be Archived (Y/N): '

    on_spotify = gets.chomp.downcase



    if on_spotify == 'y'

      on_spotify = true

    elsif on_spotify == 'n'

      on_spotify = false

    else

      puts "ERROR: Invalid answer. Value set to 'N'"

      on_spotify = false

    end



    @music_albums.push(MusicAlbum.new(@genre, @author, @source, @label, publish_date, on_spotify))

    puts 'Music Album added successfully!'
  end

  def list_all_genres
    if @genres.empty?

      puts "\nNo genres yet"

    else

      puts "\nGenres:"

      @genres.each_with_index do |genre, index|
        puts "#{index + 1}: #{genre.genre_name}"
      end

    end
  end

  def quit
    PreserveMusicAlbums.new.save_music_albums(@music_albums)

    PreserveGenres.new.save_genres(@genres)

    PreserveMovies.new.save_movies(@movie)
    PreserveGames.new.save_games(@games)

    puts 'Thank you for using this app!'

    exit
  end
end

# rubocop:enable Metrics/ClassLength
