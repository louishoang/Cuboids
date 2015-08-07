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

  def move_to(new_origin:)
    raise InvalidMoveError unless can_move?(new_origin)
    move_to!(new_origin)
  end

  def rotate(about_dimension:, clockwise:)
    rotate!(about_dimension, clockwise)
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

  def rotate!(axis, clockwise)
    # axis should be 0, 1, or 2, corresponding with which axis
    # x => 0; y => 1, z => 2
    first_dim, second_dim = dimensions.take(axis) + dimensions.drop(axis + 1)
    if axis == 0
      first_dim, second_dim = clockwise ? [(second_dim * -1), first_dim] : [second_dim, (first_dim * -1)]
    else
      first_dim, second_dim = clockwise ? [second_dim, (first_dim * -1)] : [(second_dim * -1), first_dim]
    end

    update_dimensions(axis, [first_dim, second_dim])
    @vertices.update(dimensions: dimensions)
    @faces.update(dimensions: dimensions)
  end

  def update_dimensions(axis, replacements)
    idx = 0

    dimensions.each_index do |dim_idx|
      next if dim_idx == axis
      dimensions[dim_idx] = replacements[idx] 
      idx += 1
    end
  end

  def can_rotate?(about_dimension, clockwise)
    !container.has_rotation_violations_with?(self, new_origin)
  end
end
