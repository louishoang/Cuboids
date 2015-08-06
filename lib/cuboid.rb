class InvalidMoveError < StandardError
end

class Cuboid
  attr_reader :origin, :dimensions, :faces, :container

  def initialize(origin:, dimensions:, container:)
    raise ArgumentError if dimensions.any? { |value| value == 0 }

    @origin = origin
    @dimensions = dimensions
    @container = container
    @vertices = Vertices.new(origin: origin, dimensions: dimensions)
    @faces = Faces.new(origin: origin, dimensions: dimensions)
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

  def faces_collection
    @faces.collection
  end

  def intersects?(other_cuboid)
    if volume <= other_cuboid.volume
      faces.are_aligning_or_overlapping_with?(other_cuboid.faces)
    else
      other_cuboid.intersects?(self)
    end
  end

  def move_to(new_origin)
    raise InvalidMoveError unless can_move?(new_origin)
    move_to!(new_origin)
  end

  private

  def move_to!(new_origin)
    @origin = new_origin
    @vertices.update(origin: new_origin)
    @faces.update(origin: new_origin)
  end

  def can_move?(new_origin)
    !container.has_move_violations_with?(self, new_origin)
  end
end
