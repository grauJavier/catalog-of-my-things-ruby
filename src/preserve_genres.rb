require 'json'
require_relative 'genre'

class PreserveGenres
  def gets_genres
    return unless File.exist?('./src/genres.json')

    genres = []
    file = File.read('./src/genres.json')
    genres_data = JSON.parse(file)
    genres_data['genres'].each do |genre_name|
      genres << Genre.new(genre_name)
    end
    genres
  end

  def save_genres(genres)
    return if genres.empty?

    genres_data = { genres: genres.map(&:genre_name) }
    File.open('./src/genres.json', 'w') do |file|
      file.puts(JSON.generate(genres_data))
    end
  end
end
