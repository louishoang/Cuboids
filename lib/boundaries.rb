require 'faces'

class Boundaries < Faces
  def has_outside_or_overlapping?(faces)
    planes = [
      [yz_planes, faces.yz_planes],
      [xz_planes, faces.xz_planes],
      [xy_planes, faces.xy_planes]
    ]

    planes.any? { |dim| outside_or_not_inside_of?(dim[0], dim[1]) }
  end

  private

  def outside_or_not_inside_of?(boundary_planes, face_planes)
    outside_of?(boundary_planes, face_planes) || not_inside_of?(boundary_planes, face_planes)
  end

  def outside_of?(boundary_planes, face_planes)
    (boundary_planes[0] > face_planes[1] && boundary_planes[1] > face_planes[1]) || (boundary_planes[0] < face_planes[0] && boundary_planes[1] < face_planes[0])
  end

  def not_inside_of?(boundary_planes, face_planes)
    !(boundary_planes[0] <= face_planes[0] && boundary_planes[1] >= face_planes[1])
  end
end
