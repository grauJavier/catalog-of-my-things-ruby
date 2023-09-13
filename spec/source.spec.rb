require_relative '../src/source'
require_relative '../src/item'

describe Source do
  let(:source_name) { 'DVD' }
  subject(:source) { described_class.new(source_name) }

  describe '#initialize' do
    it 'creates a new Source instance with a source_name' do
      expect(source.source_name).to eq(source_name)
    end

    it 'generates a random id' do
      expect(source.id).to be_a(Integer)
    end

    it 'initializes an empty items array' do
      expect(source.items).to be_empty
    end
  end

  describe '#add_item' do
    let(:item) { Item.new(nil, nil, source, nil, nil) }

    context 'when adding a valid item' do
      it 'adds the item to the items array' do
        expect { source.add_item(item) }.to change { source.items.length }.by(1)
      end

      it 'sets the source attribute of the item to the current source' do
        source.add_item(item)
        expect(item.source).to eq(source)
      end
    end

    context 'when adding an invalid item' do
      it 'raises a TypeError' do
        invalid_item = 'Not an Item instance'
        expect { source.add_item(invalid_item) }.to raise_error(TypeError, 'Invalid type, must be an Item instance')
      end


      it "doesn't add the item to the items array" do
        invalid_item = 'Not an Item instance'
        expect do
          source.add_item(invalid_item)
        rescue StandardError
          nil
        end.not_to(change { source.items.length })
      end
    end
  end
end
