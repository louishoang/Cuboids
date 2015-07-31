class Cuboid
  attr_reader :origin, :dimensions

  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
  end

  def length
    dimensions[0]
  end

  def width
    dimensions[1]
  end

  def height
    dimensions[2]
  end

  def move_to!(x, y, z)
  end
  
  #returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other)
  end
end