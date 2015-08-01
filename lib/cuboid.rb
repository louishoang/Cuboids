class Cuboid
  #BEGIN public methods that should be your starting point
  attr_reader :origin, :dimensions, :faces

  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
    @vertices = Vertices.new(origin: origin, dimensions: dimensions)
    @faces = Faces.new(origin: origin, dimensions: dimensions)
  end

  def length
    @length ||= dimensions[0]
  end

  def width
    @width ||= dimensions[1]
  end

  def height
    @height ||= dimensions[2]
  end

  def volume
    @volume ||= length * width * height 
  end

  def vertices
    @vertices.collection
  end

  def move_to!(x, y, z)
  end

  #returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other)
    if volume <= other.volume
      faces.overlap?(other.faces)
    else
      other.intersects?(self)
    end
  end
end
