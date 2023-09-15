require_relative '../src/author'
require_relative '../src/item'
require_relative '../src/genre'
require_relative '../src/label'
require_relative '../src/source'

describe Author do
  let(:first_name) { 'Khaled' }
  let(:last_name) { 'Hosseini' }

  subject(:author) do
    described_class.new(first_name, last_name)
  end

  describe '#initialize' do
    it 'creates an author with the specified attributes' do
      expect(author.first_name).to eq(first_name)
      expect(author.last_name).to eq(last_name)
    end
  end

  describe '#add_item' do
    it 'adds an item to the author\'s items' do
      item = Item.new(
        Genre.new('Fiction'),
        author,
        Source.new('Library'),
        Label.new('Book Title', 'Blue'),
        2022
      )

      author.add_item(item)
      expect(author.items).to include(item)
      expect(item.author).to eq(author)
    end

    it 'raises a TypeError when adding an item of an invalid type' do
      invalid_item = 'Not an Item instance'
      expect { author.add_item(invalid_item) }.to raise_error(TypeError)
    end
  end
end
