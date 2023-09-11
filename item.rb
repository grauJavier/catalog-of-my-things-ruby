class Item
  attr_accessor :title, :published_date, :archived

  def initialize(title, published_date)
    @title = title
    @published_date = published_date
    @archived = false
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
