require_relative 'src/author'
require_relative 'src/genre'
require_relative 'src/label'
require_relative 'src/source'
require_relative 'src/item'
require_relative 'src/book/book'
require_relative 'src/music_album/music_album'
require_relative 'src/music_album/preserve_music_albums'
require_relative 'src/preserve_genres'

require_relative 'helper'
# rubocop:disable Metrics/ClassLength

class App
  attr_accessor :music_albums

  def initialize
    @music_albums = PreserveMusicAlbums.new.gets_music_albums || []
    @genres = PreserveGenres.new.gets_genres || []
    @movie = PreserveMovies.new.gets_movies || []
    @books = []
    @labels = []
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
    @genres << @genre

    print 'Color: '
    color = gets.chomp

    @label = Label.new(title, color)

    return if @labels.any? { |label| label.title == title }
    @labels << @label    
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

  ########################################## dani code start ##########################################
  def add_a_book
    add_genre
    add_author('book')
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

    print 'Publisher: '
    publisher = gets.chomp

    print 'Cover state: '
    cover_state = gets.chomp

    book_params = {
      genre: @genre,
      author: @author,
      source: @source,
      label: @label,
      publish_date: publish_date,
      publisher: publisher,
      cover_state: cover_state
    }

    @books.push(Book.new(book_params))
    puts 'Book added successfully!'
  end

  def list_all_books
    if @books.empty?
      puts "\nNo books yet"
    else
      puts "\nBooks:"
      @books.each_with_index do |book, index|
        title = book.label.title
        author = book.author.first_name + ' ' + book.author.last_name
        genre = book.genre.genre_name

        output = "#{index}: TITLE: #{title} | AUTHOR: #{author} | GENRE: #{genre} | "
        output += if book.publish_date.zero?
                    "RELEASE DATE: 'Unknown' | "
                  else
                    "RELEASE DATE: #{book.publish_date} | "
                  end

        output += if book.publisher.empty?
                    "PUBLISHER: 'Unknown' | "
                  else
                    "PUBLISHER: #{book.publisher} | "
                  end

        output += if book.cover_state.empty?
                    'COVER STATE: Unknown'
                  else
                    "COVER STATE: #{book.cover_state}"
                  end

        puts output
      end
    end
  end

  def list_all_labels
    if @labels.empty?
      puts "\nNo labels yet"
    else
      puts "\nLabels:"
      @labels.each_with_index do |label, index|
        puts "#{index + 1}: #{label.title} | #{label.color}"
      end
    end
  end

  ########################################## dani code end ##########################################

  def quit
    PreserveMusicAlbums.new.save_music_albums(@music_albums)
    PreserveGenres.new.save_genres(@genres)
    PreserveMovies.new.save_movies(@movie)
    puts 'Thank you for using this app!'
    exit
  end
end
# rubocop:enable Metrics/ClassLength
