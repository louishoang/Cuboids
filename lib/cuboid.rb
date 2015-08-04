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

  def intersects?(other_cuboid)
    if volume <= other_cuboid.volume
      faces.overlap?(other_cuboid.faces)
    else
      other_cuboid.intersects?(self)
    end
  end

  def move_to(new_origin)
    #if can_move
      move_to!(new_origin)
    #end
  end

  private

  def move_to!(new_origin)
    @origin = new_origin
    @vertices.update(origin: new_origin)
  end

  def can_move
    # make new one and move_to! + check if collides with anything
  end
end
