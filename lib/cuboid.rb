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

  def rotate_along(axis:, clockwise:)
    # axis should be 0, 1, or 2, corresponding with which axis
    # x => 0; y => 1, z => 2
    raise InvalidMoveError unless can_rotate?(axis, clockwise)
    rotate_along!(axis, clockwise)
  end

  protected

  def rotate_along!(axis, clockwise)
    perform_rotation_along(axis, dimensions_according_to(axis, clockwise))
    @vertices.update(dimensions: dimensions)
    @faces.update(dimensions: dimensions)
  end

  def dimensions_according_to(axis, clockwise)
    first_dim, second_dim = dimensions.take(axis) + dimensions.drop(axis + 1)
    determine_dimensions_from(axis, clockwise, first_dim, second_dim)
  end

  def determine_dimensions_from(axis, clockwise, first_dim, second_dim)
    if axis == 0
      clockwise ? [(second_dim * -1), first_dim] : [second_dim, (first_dim * -1)]
    else
      clockwise ? [second_dim, (first_dim * -1)] : [(second_dim * -1), first_dim]
    end
  end

  def perform_rotation_along(axis, replacements, idx = 0)
    dimensions.each_index do |dim_idx|
      next if dim_idx == axis
      @dimensions[dim_idx] = replacements[idx]
      idx += 1
    end
  end

  private

  def move_to!(new_origin)
    @origin = new_origin
    @vertices.update(origin: new_origin)
    @faces.update(origin: new_origin)
  end

  def can_move?(new_origin)
    dup_cuboid = Cuboid.new(origin: new_origin, dimensions: dimensions.dup, container: container)
    !container.cannot_allow_move_for?(dup_cuboid)
  end

  def can_rotate?(axis, clockwise)
    dup_cuboid = Cuboid.new(origin: origin, dimensions: dimensions.dup, container: container)
    dup_cuboid.rotate_along!(axis, clockwise)
    !container.cannot_allow_move_for?(dup_cuboid)
  end
end
