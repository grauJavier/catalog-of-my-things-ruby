require_relative '../item'

class Source
  attr_accessor :source_name
  attr_reader :id, :items

  def initialize(source_name)
    @id = rand(1..1000)
    @source_name = source_name
    @items = []
  end

  def add_item(item)
    raise TypeError, 'Invalid type, must be an Item instance' unless item.is_a?(Item)

    @items << item
    item.genre = self
  end
end
