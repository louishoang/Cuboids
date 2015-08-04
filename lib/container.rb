class Container# describing the container in which all boxes Container # describing the container in which all boxes live
  attr_reader :origin, :dimensions

  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
    @vertices = Vertices.new(origin: origin, dimensions: dimensions)
    @boundaries = Boundaries.new(origin: origin, dimensions: dimensions)
  end

  def length
    @length ||= dimensions[0].abs
  end

  def width
    @width ||= dimensions[1].abs
  end

  def height
    @height ||= dimensions[2].abs
  end

  def volume
    @volume ||= length * width * height
  end

  def vertices
    @vertices.collection
  end

  def intersects?(cuboid)
    if volume < cuboid.volume
      true
    else
      @boundaries.out_of_bounds?(cuboid.faces)
    end
  end
end
