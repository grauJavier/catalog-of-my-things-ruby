require_relative '../src/genre'
require_relative '../src/item'

describe Genre do
  let(:genre_name) { 'Rock' }

  subject(:genre) { described_class.new(genre_name) }

  describe '#initialize' do
    it 'creates a genre with a name and generates an ID' do
      expect(genre.genre_name).to eq('Rock')
      expect(genre.id).to be_a(Integer)
    end
  end

  describe '#add_item' do
    it 'adds an item to the genre' do
      item = Item.new('Item Title', 'Argument', 2000, 'Some Other Argument', 'Another Argument')
      genre.add_item(item)

      expect(genre.items).to include(item)
      expect(item.genre).to eq(genre)
    end

    it 'raises an error when adding an invalid item' do
      invalid_item = 'This is not an Item instance'
      expect { genre.add_item(invalid_item) }.to raise_error(TypeError, 'Invalid type, must be an Item instance')
    end
  end
end
