require_relative '../item'

class MusicAlbum < Item
  attr_reader :on_spotify, :name, :id
  attr_accessor :archived

  def initialize(title, published_date, on_spotify)
    super(title, published_date)
    @id = rand(1...100)
    @on_spotify = on_spotify
    @name = name
    @archived = can_be_archived?
  end

  def can_be_archived?
    super && @on_spotify = true
  end
end
