require_relative 'item'

class Genre
  attr_accessor :genre_name
  attr_reader :id, :items

  def initialize(genre_name)
    @id = rand(1..1000)
    @genre_name = genre_name
    @items = []
  end

  def add_item(item)
    raise TypeError, 'Invalid type, must be an Item instance' unless item.is_a?(Item)

    @items << item
    item.genre = self
  end
end
