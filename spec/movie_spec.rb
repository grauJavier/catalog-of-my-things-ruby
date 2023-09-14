require_relative '../src/movie/movie'
require_relative '../src/item'
require_relative '../src/genre'
require_relative '../src/author'
require_relative '../src/label'
require_relative '../src/source'

describe Movie do
  let(:genre) { Genre.new('Action') }
  let(:author) { Author.new('John', 'Doe') }
  let(:source) { Source.new('DVD') }
  let(:label) { Label.new('Movie Title', 'Red') }
  let(:publish_date) { 2010 }

  subject(:movie) { described_class.new(genre, author, source, label, publish_date, true) }

  describe '#can_be_archived?' do
    context 'when the movie can be archived' do
      it 'returns true' do
        expect(movie.can_be_archived?).to be(true)
      end
    end

    context 'when the movie cannot be archived' do
      it 'returns false' do
        movie.silet = false
        expect(movie.can_be_archived?).to be(false)
      end
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the movie' do
      expected_hash = {
        'genre' => { 'genre_name' => 'Action' },
        'author' => { 'first_name' => 'John', 'last_name' => 'Doe' },
        'source' => { 'source_name' => 'DVD' },
        'label' => { 'title' => 'Movie Title', 'color' => 'Red' },
        'publish_date' => 2010,
        'silet' => true
      }

      expect(movie.to_hash).to eq(expected_hash)
    end
  end

  describe '.from_hash' do
    it 'creates a movie object from a hash' do
      movie_hash = {
        'genre' => { 'genre_name' => 'Action' },
        'author' => { 'first_name' => 'John', 'last_name' => 'Doe' },
        'source' => { 'source_name' => 'DVD' },
        'label' => { 'title' => 'Movie Title', 'color' => 'Red' },
        'publish_date' => 2023,
        'silet' => true
      }

      result_movie = described_class.from_hash(movie_hash)

      expect(result_movie.genre.genre_name).to eq('Action')
      expect(result_movie.author.first_name).to eq('John')
      expect(result_movie.source.source_name).to eq('DVD')
      expect(result_movie.label.title).to eq('Movie Title')
      expect(result_movie.publish_date).to eq(2023)
      expect(result_movie.silet).to be(true)
    end
  end
end
