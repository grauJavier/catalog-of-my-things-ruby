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
end
