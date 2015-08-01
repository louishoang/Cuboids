class Faces
  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
  end

  def overlap?(other_faces)
    plane_dims = [
      [due_x, other_faces.due_x],
      [due_y, other_faces.due_y],
      [due_z, other_faces.due_z]
    ]

    plane_dims.all? { |dim| overlap_between?(dim[0], dim[1]) }
  end

  protected

  def due_x # yz-planes
    @due_x ||= determine_planes(0)
  end

  def due_y # xz-planes
    @due_y ||= determine_planes(1)
  end

  def due_z # xy-planes
    @due_z ||= determine_planes(2)
  end

  private

  attr_reader :origin, :dimensions

  def determine_planes(idx)
    [origin[idx], origin[idx] + dimensions[idx]]
  end

  def both_align?(due_dim, other_due_dim)
    [0, 1].all? { |idx| due_dim[idx] == other_due_dim[idx] }
  end

  def in_between?(due_dim, other_due_dim)
    due_dim.any? do |dimension|
      dimension > other_due_dim[0] && dimension < other_due_dim[1]
    end
  end

  def overlap_between?(due_dim, other_due_dim)
    both_align?(due_dim, other_due_dim) || in_between?(due_dim, other_due_dim)
  end
end

