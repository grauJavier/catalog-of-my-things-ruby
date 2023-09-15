require_relative 'app'

class Main
  def initialize
    @app = App.new
    @menu = {
      '1' => 'list_all_books', '2' => 'list_all_music_albums',
      '3' => 'list_all_movies', '4' => 'list_all_games',
      '5' => 'list_all_genres', '6' => 'list_all_labels',
      '7' => 'list_all_authors', '8' => 'list_all_sources',
      '9' => 'add_a_book', '10' => 'add_a_music_album',
      '11' => 'add_a_movie', '12' => 'add_a_game',
      '13' => 'quit'
    }.freeze
  end

  def menu
    puts "\nPlease choose an option by enter a number"
    @menu.each { |key, element| puts "#{key} - #{element.capitalize.gsub '_', ' '}" }
    print "\nYour option: "
    action = @menu[gets.chomp]
    if action
      action
    else
      puts "\nInvalid option select a valid one\n\n"
      menu
    end
  end

  def start
    puts "Welcome to My Favorite Things Catalog\n\n"
    loop do
      @app.send(menu)
    end
  end
end

Main.new.start
