require 'json'

class PreserveMovies
  def gets_movies
    return [] unless File.exist?('./src/movie/movies.json')

    saved_movies = []
    file = File.read('./src/movie/movies.json')
    return [] if file.empty?

    data_hashes = JSON.parse(file)
    data_hashes.each do |movie|
      saved_movies << Movie.from_hash(movie)
    end
    saved_movies
  end

  def save_movies(movies)
    return if movies.empty?

    data_hashes = movies.map(&:to_hash)
    File.write('./src/movie/movies.json', JSON.pretty_generate(data_hashes))
  end
end
