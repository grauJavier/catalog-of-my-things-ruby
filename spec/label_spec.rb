require_relative '../src/label'
require_relative '../src/item'

describe Label do
  let(:title) { 'Book Title' }
  let(:color) { 'Blue' }
  subject(:label) { described_class.new(title, color) }

  describe '#initialize' do
    it 'creates a label with the specified attributes' do
      expect(label.title).to eq(title)
      expect(label.color).to eq(color)
    end

    it 'initializes an empty items array' do
      expect(label.items).to be_empty
    end

    it 'generates an ID' do
      expect(label.id).to be_a(Integer)
    end
  end

  describe '#add_item' do
    it 'adds an item to the label' do
      item = Item.new('Fiction', 'Daniel Morillo', 'Library', label, 2022)
      label.add_item(item)

      expect(label.items).to include(item)
    end

    it 'sets the label of the added item to itself' do
      item = Item.new('Fiction', 'Daniel Morillo', 'Library', label, 2022)
      label.add_item(item)

      expect(item.label).to eq(label)
    end

    it 'raises a TypeError if the argument is not an Item instance' do
      expect { label.add_item('Invalid Item') }.to raise_error(TypeError)
    end
  end
end
