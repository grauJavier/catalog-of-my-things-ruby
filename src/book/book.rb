require_relative '../item'

class Book < Item
  attr_accessor :publisher, :cover_state
  attr_reader :archived

  def initialize(args)
    super(args[:genre], args[:author], args[:source], args[:label], args[:publish_date])
    @publisher = args[:publisher]
    @cover_state = args[:cover_state]
  end

  def can_be_archived?
    super || @cover_state == 'good'
  end

  def to_hash
    {
      'genre' => {
        'genre_name' => @genre.genre_name
      },
      'author' => {
        'first_name' => @author.first_name,
        'last_name' => author.last_name
      },
      'source' => {
        'source_name' => @source.source_name
      },
      'label' => {
        'title' => @label.title,
        'color' => @label.color
      },
      'publish_date' => @publish_date,
      'publisher' => @publisher,
      'cover_state' => @cover_state
    }
  end

  def self.from_hash(hash)
    new(
      genre: Genre.new(hash['genre']['genre_name']),
      author: Author.new(hash['author']['first_name'], hash['author']['last_name']),
      source: Source.new(hash['source']['source_name']),
      label: Label.new(hash['label']['title'], hash['label']['color']),
      publish_date: hash['publish_date'],
      publisher: hash['publisher'],
      cover_state: hash['cover_state']
    )
  end
end
