require_relative '../item'

class MusicAlbum < Item
  attr_accessor :on_spotify
  attr_reader :archived

  def initialize(genre, author, source, label, publish_date, on_spotify)
    super(genre, author, source, label, publish_date)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify == true
  end

  def to_hash
    {
      'genre' => {
        'genre_name' => @genre.genre_name
      },
      'author' => {
        'first_name' => @author.first_name,
        'last_name' => @author.last_name
      },
      'source' => {
        'source_name' => @source.source_name
      },
      'label' => {
        'title' => @label.title,
        'color' => @label.color
      },
      'publish_date' => @publish_date,
      'on_spotify' => @on_spotify
    }
  end

  def self.from_hash(hash)
    new(
      Genre.new(hash['genre']['genre_name']),
      Author.new(hash['author']['first_name'], hash['author']['last_name']),
      Source.new(hash['source']['source_name']),
      Label.new(hash['label']['title'], hash['label']['color']),
      hash['publish_date'],
      hash['on_spotify']
    )
  end
end
