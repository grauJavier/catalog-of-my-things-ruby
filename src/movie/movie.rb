class Movie < Item
  attr_accessor :silet

  def initialize( silet: false, **args)
    super(**args)
    @silet = silet
  end

  def can_be_archived?
    super || @silent == true
  end
end
