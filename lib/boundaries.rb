class Boundaries
  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
  end

  def collection
    @collection ||= build_collection
  end

  def has_outside_or_overlapping?(faces)
    planes = [collection, faces.collection].transpose
    planes.any? { |dim| outside_or_not_inside_of?(dim.first, dim.last) }
  end

  private

  attr_reader :origin, :dimensions

  def yz_planes
    @yz_planes ||= determine_lesser_and_greater_planes(0)
  end

  def xz_planes
    @xz_planes ||= determine_lesser_and_greater_planes(1)
  end

  def xy_planes
    @xy_planes ||= determine_lesser_and_greater_planes(2)
  end

  def build_collection
    [yz_planes, xz_planes, xy_planes]
  end

  def determine_lesser_and_greater_planes(idx)
    l_plane, g_plane = origin[idx], origin[idx] + dimensions[idx]
    l_plane > g_plane ? [g_plane, l_plane] : [l_plane, g_plane]
  end

  def outside_or_not_inside_of?(b_planes, f_planes)
    outside_of?(b_planes, f_planes) || not_inside_of?(b_planes, f_planes)
  end

  def outside_of?(b_planes, f_planes)
    (b_planes.first > f_planes.last && b_planes.last > f_planes.last) ||
    (b_planes.first < f_planes.first && b_planes.last < f_planes.first)
  end

  def not_inside_of?(b_planes, f_planes)
    !(b_planes.first <= f_planes.first && b_planes.last >= f_planes.last)
  end
end
