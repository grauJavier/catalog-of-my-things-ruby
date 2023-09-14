require_relative '../item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(genre, author, source, label, publish_date, multiplayer, last_played_at)
    super(genre, author, source, label, publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at.to_i
  end

  def can_be_archieved?
    Date.today.year - last_played_at.year > 2
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
      'multiplayer' => @multiplayer,
      'last_played_at' => @last_played_at
    }
  end

  def self.from_hash(hash)
    new(
      Genre.new(hash['genre']['genre_name']),
      Author.new(hash['author']['first_name'], hash['author']['last_name']),
      Source.new(hash['source']['source_name']),
      Label.new(hash['label']['title'], hash['label']['color']),
      hash['publish_date'],
      hash['multiplayer'],
      hash['last_played_at']
    )
  end
end
