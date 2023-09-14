require_relative '../src/book/book'
require_relative '../src/item'
require_relative '../src/genre'
require_relative '../src/author'
require_relative '../src/label'
require_relative '../src/source'
describe Book do
  let(:genre) { Genre.new('Magical Realism') }
  let(:author) { Author.new('Gabriel', 'García Márquez') }
  let(:source) { Source.new('Local Bookstore') }
  let(:label) { Label.new('One Hundred Years of Solitude', 'Yellow') }
  let(:publish_date) { 1967 }
  let(:publisher) { 'Publisher XYZ' }
  let(:cover_state) { 'Very Good' }

  subject(:book) do
    described_class.new(
      genre: genre,
      author: author,
      source: source,
      label: label,
      publish_date: publish_date,
      publisher: publisher,
      cover_state: cover_state
    )
  end

  describe '#initialize' do
    it 'creates a book with the specified attributes' do
      expect(book.genre).to eq(genre)
      expect(book.author).to eq(author)
      expect(book.source).to eq(source)
      expect(book.label).to eq(label)
      expect(book.publish_date).to eq(publish_date)
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq(cover_state)
    end

    it 'inherits from Item' do
      expect(book.is_a?(Item)).to be true
    end
  end

  describe '#can_be_archived?' do
    it 'returns true when cover state is very good' do
      book.cover_state = 'good'
      expect(book.can_be_archived?).to be true
    end

    it 'calls the parent class implementation when cover state is not good' do
      book.cover_state = 'Poor'
      allow(book).to receive(:super).and_return(false)
      expect(book.can_be_archived?).to be false
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the book' do
      hash = book.to_hash
      expect(hash['genre']['genre_name']).to eq(genre.genre_name)
      expect(hash['author']['first_name']).to eq(author.first_name)
      expect(hash['author']['last_name']).to eq(author.last_name)
      expect(hash['source']['source_name']).to eq(source.source_name)
      expect(hash['label']['title']).to eq(label.title)
      expect(hash['label']['color']).to eq(label.color)
      expect(hash['publish_date']).to eq(publish_date)
      expect(hash['publisher']).to eq(publisher)
      expect(hash['cover_state']).to eq(cover_state)
    end
  end

  describe '.from_hash' do
    it 'creates a book from a hash representation' do
      hash = {
        'genre' => { 'genre_name' => 'Historical Fiction' },
        'author' => { 'first_name' => 'Isabel', 'last_name' => 'Allende' },
        'source' => { 'source_name' => 'Local Bookstore' },
        'label' => { 'title' => 'The House of the Spirits', 'color' => 'Green' },
        'publish_date' => 1982,
        'publisher' => 'Another Publisher',
        'cover_state' => 'Excellent'
      }

      book = described_class.from_hash(hash)
      expect(book.genre.genre_name).to eq('Historical Fiction')
      expect(book.author.first_name).to eq('Isabel')
      expect(book.author.last_name).to eq('Allende')
      expect(book.source.source_name).to eq('Local Bookstore')
      expect(book.label.title).to eq('The House of the Spirits')
      expect(book.label.color).to eq('Green')
      expect(book.publish_date).to eq(1982)
      expect(book.publisher).to eq('Another Publisher')
      expect(book.cover_state).to eq('Excellent')
    end
  end
end
