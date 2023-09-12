class Item
  attr_accessor :genre, :author, :source, :label, :publish_date
  attr_reader :archived, :id

  def initialize(genre, author, source, label, publish_date)
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
    @archived = false
    @id = rand(1..1000)

    source&.add_item(self)
  end

  def can_be_archived?
    current_year = Time.now.year
    current_year - @publish_date > 10
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
