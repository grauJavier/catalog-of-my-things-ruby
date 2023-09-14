require_relative '../src/music_album/music_album'
require_relative '../src/genre'
require_relative '../src/author'
require_relative '../src/label'
require_relative '../src/source'

describe MusicAlbum do
  let(:genre) { Genre.new('Rock') }
  let(:author) { Author.new('The Beatles', '') }
  let(:source) { Source.new('CD') }
  let(:label) { Label.new('Album Title', 'Blue') }
  let(:publish_date) { 2000 }

  subject(:music_album) do
    described_class.new(
      genre: genre,
      author: author,
      source: source,
      label: label,
      publish_date: publish_date,
      on_spotify: true
    )
  end

  describe '#can_be_archived?' do
    context 'when the music album can be archived' do
      it 'returns true' do
        expect(music_album.can_be_archived?).to be(true)
      end
    end

    context 'when the music album cannot be archived' do
      it 'returns false' do
        music_album.on_spotify = false
        expect(music_album.can_be_archived?).to be(false)
      end
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the music album' do
      expected_hash = {
        'genre' => { 'genre_name' => 'Rock' },
        'author' => { 'first_name' => 'The Beatles', 'last_name' => '' },
        'source' => { 'source_name' => 'CD' },
        'label' => { 'title' => 'Album Title', 'color' => 'Blue' },
        'publish_date' => 2000,
        'on_spotify' => true
      }

      expect(music_album.to_hash).to eq(expected_hash)
    end
  end
end
