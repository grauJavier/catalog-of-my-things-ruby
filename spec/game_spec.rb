require_relative '../src/game/game'
require_relative '../src/item'
require_relative '../src/genre'
require_relative '../src/author'
require_relative '../src/label'
require_relative '../src/source'

describe Game do
  let(:genre) { Genre.new('Action') }
  let(:author) { Author.new('Khaled', 'Hosseini') }
  let(:source) { Source.new('Steam') }
  let(:label) { Label.new('Game Title', 'Red') }
  let(:publish_date) { 2019 }
  let(:multiplayer) { true }
  let(:last_played_at) { 2022 }

  subject(:game) do
    described_class.new(
      genre: genre,
      author: author,
      source: source,
      label: label,
      publish_date: publish_date,
      multiplayer: multiplayer,
      last_played_at: last_played_at
    )
  end

  describe '#initialize' do
    it 'creates a game with the specified attributes' do
      expect(game.genre).to eq(genre)
      expect(game.author).to eq(author)
      expect(game.source).to eq(source)
      expect(game.label).to eq(label)
      expect(game.publish_date).to eq(publish_date)
      expect(game.multiplayer).to eq(multiplayer)
      expect(game.last_played_at).to eq(2022)
    end

    it 'inherits from Item' do
      expect(game.is_a?(Item)).to be true
    end
  end

  describe '#can_be_archived?' do
    it 'returns true when last played more than 2 years ago' do
      game.last_played_at = 2019
      expect(game.can_be_archived?).to be false
    end

    it 'returns false when last played less than 2 years ago' do
      game.last_played_at = 2020
      expect(game.can_be_archived?).to be false
    end

    it 'returns true when last played more than 2 years ago' do
      game.last_played_at = 2018
      game.publish_date = 2010
      expect(game.can_be_archived?).to be true
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the game' do
      hash = game.to_hash
      expect(hash['genre']['genre_name']).to eq(genre.genre_name)
      expect(hash['author']['first_name']).to eq(author.first_name)
      expect(hash['author']['last_name']).to eq(author.last_name)
      expect(hash['source']['source_name']).to eq(source.source_name)
      expect(hash['label']['title']).to eq(label.title)
      expect(hash['label']['color']).to eq(label.color)
      expect(hash['publish_date']).to eq(publish_date)
      expect(hash['multiplayer']).to eq(multiplayer)
      expect(hash['last_played_at']).to eq(2022)
    end
  end

  describe '.from_hash' do
    it 'creates a game from a hash representation' do
      hash = {
        'genre' => { 'genre_name' => 'Adventure' },
        'author' => { 'first_name' => 'Khaled', 'last_name' => 'Hosseini' },
        'source' => { 'source_name' => 'Epic Games Store' },
        'label' => { 'title' => 'Game Title 2', 'color' => 'Green' },
        'publish_date' => 2021,
        'multiplayer' => false,
        'last_played_at' => 2023
      }

      game = described_class.from_hash(hash)
      expect(game.genre.genre_name).to eq('Adventure')
      expect(game.author.first_name).to eq('Khaled')
      expect(game.author.last_name).to eq('Hosseini')
      expect(game.source.source_name).to eq('Epic Games Store')
      expect(game.label.title).to eq('Game Title 2')
      expect(game.label.color).to eq('Green')
      expect(game.publish_date).to eq(2021)
      expect(game.multiplayer).to be false
      expect(game.last_played_at).to eq(2023)
    end
  end
end
