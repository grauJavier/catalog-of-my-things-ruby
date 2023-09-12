class Movie
  attr_accessor :silet, :release_year

  def initialize(release_year, silet: false)
    @silet = silet
    @release_year = release_year
  end

  def can_be_archived?
    @release_year < 2000
  end
end
