class Container
  attr_reader :origin, :dimensions

  def initialize(origin:, dimensions:)
    raise ArgumentError if dimensions.any? { |value| value == 0 }

    @origin = origin
    @dimensions = dimensions
    @vertices = Vertices.new(origin: origin, dimensions: dimensions)
    @boundaries = Boundaries.new(origin: origin, dimensions: dimensions)
    @cuboids = []
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

  def vertices_collection
    @vertices.collection
  end

  def cuboids_collection
    @cuboids
  end

  def add_cuboid(origin, dimensions)
    cuboid = Cuboid.new(origin: origin, dimensions: dimensions, container: self)
    raise StandardError if has_an_out_of_bounds?(cuboid) || has_other_intersecting_cuboid_with?(cuboid)
    @cuboids << cuboid
  end

  def has_violations_with?(cuboid)
    dup_container = self.class.new(origin: origin, dimensions: dimensions)

    @cuboids.each do |other_cuboid|
      next if cuboid == other_cuboid
      dup_container.add_cuboid(other_cuboid.origin, other_cuboid.dimensions)
    end

    dup_container.has_an_out_of_bounds?(cuboid) || dup_container.has_other_intersecting_cuboid_with?(cuboid)
  end

  def has_other_intersecting_cuboid_with?(cuboid)
    @cuboids.any? do |other_cuboid|
      next if cuboid == other_cuboid
      cuboid.intersects?(other_cuboid)
    end
  end

  def has_an_out_of_bounds?(cuboid)
    return true if volume < cuboid.volume
    @boundaries.has_outside_or_overlapping?(cuboid.faces)
  end
end
