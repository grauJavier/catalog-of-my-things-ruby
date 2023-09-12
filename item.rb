class Item
  attr_accessor :id, :genre, :author, :source, :label, :published_date, :archived

  def initialize(genre, author, source, label, published_date)
    @id = random(1..1000)
    @genre = genre
    @author = author
    @source = source
    @label = label
    @published_date = published_date
    @archived = false
    source&.add_item(self)
  end

  def can_be_archived?
    current_year = Time.now.year
    current_year - @published_date > 10
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      puts "#{@title} has been archived."
    else
      puts "#{@title} cannot be archived yet."
    end
  end
end
