require_relative 'helper'

class App
  attr_accessor :music_albums, :movies, :genres, :sources, :games, :books, :labels, :authors

  def initialize
    @books = PreserveBooks.new.gets_books || []
    @music_albums = PreserveMusicAlbums.new.gets_music_albums || []
    @movies = PreserveMovies.new.gets_movies || []
    @games = PreserveGames.new.gets_games || []
    @genres = PreserveGenres.new.gets_genres || []
    @labels = PreserveLabels.new.gets_labels || []
    @authors = PreserveAuthors.new.gets_authors || []
    @sources = PreserveSources.new.gets_sources || []
  end

  def add_genre
    print 'Genre: '
    genre_name = gets.chomp.to_s
    @genre = Genre.new(genre_name)
    return if @genres.any? { |genre| genre.genre_name == genre_name }

    @genres << @genre
  end

  def add_author(item)
    if item == 'music_album'
      print 'Artist: '
      first_name = gets.chomp.to_s
      @author = Author.new(first_name, '')
    elsif item == 'movie'
      print "Director's First Name: "
      first_name = gets.chomp.to_s

      print "Director's Last Name: "
      last_name = gets.chomp.to_s

      @author = Author.new(first_name, last_name)
    else
      print 'Author First Name: '
      first_name = gets.chomp.to_s
      print 'Author Last Name: '
      last_name = gets.chomp.to_s
      @author = Author.new(first_name, last_name)
    end

    return if @authors.any? { |author| author.first_name + author.last_name == first_name.to_s + last_name.to_s }

    @authors << @author
  end

  def add_source
    print 'Source: '
    source_name = gets.chomp.to_s
    @source = Source.new(source_name)

    return if @sources.any? { |source| source.source_name == source_name }

    @sources << @source
  end

  def add_label
    print 'Title: '
    title = gets.chomp.to_s
    print 'Color: '
    color = gets.chomp.to_s

    @label = Label.new(title, color)

    return if @labels.any? { |label| label.title + label.color == title + color }

    @labels << @label
  end

  def add_item_properties(item)
    add_genre
    add_author(item)
    add_source
    add_label

    print 'Publish Date (YEAR): '
    @publish_date = gets.chomp

    if @publish_date.match?(/\A\d+\z/)
      @publish_date = @publish_date.to_i

    else
      puts "ERROR: Invalid answer. Value set to 'Unkown'"
      @publish_date = 0
    end

    @item_params = { genre: @genre, author: @author, source: @source,
                     label: @label, publish_date: @publish_date }
  end

  def list_all_books
    if @books.empty?
      puts "\nNo books yet"
    else
      puts "\nBooks:"
      @books.each_with_index do |book, index|
        title = book.label.title
        author = book.author.last_name
        genre = book.genre.genre_name

        output = "#{index + 1}: TITLE: #{title} | AUTHOR: #{author} | GENRE: #{genre} | RELEASE DATE: #{book.publish_date} | PUBLISHER: #{book.publisher} | COVER STATE: #{book.cover_state}"
        puts output
      end
    end
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts 'No albums yet'
    else
      puts 'Albums:'
      @music_albums.each_with_index do |music_album, index|
        title = music_album.label.title
        artist = music_album.author.first_name
        genre = music_album.genre.genre_name
        output = "#{index + 1}: TITLE: #{title} | ARTIST: #{artist} | GENRE: #{genre} | "
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
    if @movies.empty?
      puts "\nNo movies yet"
    else
      puts "\nMovies:"
      @movies.each_with_index do |movie, index|
        title = movie.label.title
        artist = "#{movie.author.first_name[0].capitalize}. #{movie.author.last_name}"
        genre = movie.genre.genre_name
        output = "#{index + 1}: TITLE: #{title} | DIRECTOR: #{artist} | GENRE: #{genre} | "
        output += if movie.publish_date.zero?
                    "RELEASE DATE: 'Unknown' | "
                  else
                    "RELEASE DATE: #{movie.publish_date} | "
                  end
        output += if movie.silent == true
                    'silent: Yes'
                  else
                    'silent: No'
                  end
        puts output
      end
    end
  end

  def list_all_games
    if @games.empty?
      puts 'No games yet'
    else
      puts 'Games:'
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

        output = "#{index + 1}: TITLE: #{title} | AUTHOR: #{author} | MULTIPLAYER: #{multiplayer} |  LAST PLAYED AT: #{last_played_at} | RELEASE DATE: #{release_date}"

        puts output
      end
    end
  end

  def list_all_genres
    if @genres.empty?
      puts 'No genres yet'
    else
      puts 'Genres:'
      @genres.each_with_index do |genre, index|
        puts "#{index + 1}: #{genre.genre_name}"
      end
    end
  end

  def list_all_labels
    if @labels.empty?
      puts "\nNo labels yet"
    else
      puts "\nLabels:"
      @labels.each_with_index do |label, index|
        puts "#{index + 1}: TITLE: #{label.title} | COLOR: #{label.color}"
      end
    end
  end

  def list_all_authors
    if @authors.empty?
      puts 'No authors yet'
    else
      puts 'Authors:'
      @authors.each_with_index do |author, index|
        puts "#{index + 1}: #{author.first_name} #{author.last_name}"
      end
    end
  end

  def list_all_sources
    if @sources.empty?
      puts "\nNo movie sources yet"
    else
      puts "\nSources:"

      @sources.each_with_index do |source, index|
        puts "#{index + 1}: #{source.source_name}"
      end
    end
  end

  def add_a_book
    add_item_properties('book')

    print 'Publisher: '
    publisher = gets.chomp.to_s

    print 'Cover state: '
    cover_state = gets.chomp.to_s

    args = {
      genre: @genre,
      author: @author,
      source: @source,
      label: @label,
      publish_date: @publish_date,
      publisher: publisher,
      cover_state: cover_state
    }

    @books.push(Book.new(args))
    puts 'Book added successfully!'
  end

  def add_a_music_album
    add_item_properties('music_album')

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

    @music_albums.push(MusicAlbum.new(@genre, @author, @source, @label, @publish_date, on_spotify))
    puts 'Music Album added successfully!'
  end

  def add_a_movie
    add_item_properties('movie')

    print 'Is silent (Y/N): '
    silent = gets.chomp.downcase

    if silent == 'y'
      silent = true
    elsif silent == 'n'
      silent = false
    else
      puts "ERROR: Invalid answer. Value set to 'N'"
      silent = false
    end

    args = {
      genre: @genre,
      author: @author,
      source: @source,
      label: @label,
      publish_date: @publish_date,
      silent: silent
    }

    @movies.push(Movie.new(args))
    puts 'Movie added successfully!'
  end

  def add_a_game
    add_item_properties('game')

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
    last_played_at = gets.chomp

    args = {
      genre: @genre,
      author: @author,
      source: @source,
      label: @label,
      publish_date: @publish_date,
      multiplayer: multiplayer,
      last_played_at: last_played_at
    }

    @games.push(Game.new(args))
    puts 'Game added successfully!'
  end

  def quit
    PreserveBooks.new.save_books(@books)
    PreserveMusicAlbums.new.save_music_albums(@music_albums)
    PreserveMovies.new.save_movies(@movies)
    PreserveGames.new.save_games(@games)
    PreserveGenres.new.save_genres(@genres)
    PreserveLabels.new.save_labels(@labels)
    PreserveAuthors.new.save_authors(@authors)
    PreserveSources.new.save_sources(@sources)
    puts 'Thank you for using this app!'
    exit
  end
end
