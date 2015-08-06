require 'faces'

class Boundaries
  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
  end

  def has_outside_or_overlapping?(faces)
    planes = [
      [yz_planes, faces.yz_planes],
      [xz_planes, faces.xz_planes],
      [xy_planes, faces.xy_planes]
    ]

    planes.any? { |dim| outside_or_not_inside_of?(dim[0], dim[1]) }
  end

  def yz_planes
    @yz_planes ||= determine_planes(0)
  end

  def xz_planes
    @xz_planes ||= determine_planes(1)
  end

  def xy_planes
    @xy_planes ||= determine_planes(2)
  end

  private

  attr_reader :origin, :dimensions

  def determine_planes(idx)
    lesser_plane, greater_plane = origin[idx], origin[idx] + dimensions[idx]

    if lesser_plane > greater_plane
      lesser_plane, greater_plane = greater_plane, lesser_plane
    end

    [lesser_plane, greater_plane]
  end

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
