require 'faces'

class Boundaries < Faces
  def out_of_bounds?(faces)
    plane_dims = [
      [due_x, faces.due_x],
      [due_y, faces.due_y],
      [due_z, faces.due_z]
    ]

    plane_dims.any? { |dim| overlap_between?(dim[0], dim[1]) }
  end

  private

  def overlap_between?(due_dim, other_due_dim)
    outside?(due_dim, other_due_dim) || intersecting?(due_dim, other_due_dim)
  end

  def outside?(due_dim, other_due_dim)
    (due_dim[0] > other_due_dim[1] && due_dim[1] > other_due_dim[1]) || (due_dim[0] < other_due_dim[0] && due_dim[1] < other_due_dim[0])
  end

  def intersecting?(due_dim, other_due_dim)
    !(due_dim[0] <= other_due_dim[0] && due_dim[1] >= other_due_dim[1])
  end
end
