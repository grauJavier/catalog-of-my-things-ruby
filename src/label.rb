require_relative 'item'

class Label
  attr_accessor :title, :color
  attr_reader :items, :id

  def initialize(title, color)
    @id = rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    raise TypeError, 'Invalid type, must be an Item instance' unless item.is_a?(Item)

    @items << item
    item.label = self
  end
end
