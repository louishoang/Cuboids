class Faces
  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
  end

  def collection
    @collection ||= build_collection
  end

  def are_aligning_or_overlapping_with?(other_faces)
    planes = [collection, other_faces.collection].transpose
    planes.all? { |dim| aligning_or_overlapping_between?(dim.first, dim.last) }
  end

  def update(props)
    props = { origin: origin, dimensions: dimensions }.merge(props)
    @origin = props[:origin] unless origin == props[:origin]
    @dimensions = props[:dimensions] unless dimensions == props[:dimensions]
    @collection = build_collection
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

  def aligning_or_overlapping_between?(planes, other_planes)
    both_align?(planes, other_planes) || overlapping?(planes, other_planes)
  end

  def both_align?(planes, other_planes)
    [0, 1].all? { |idx| planes[idx] == other_planes[idx] }
  end

  def overlapping?(p, other_p)
    p.any? { |dim| dim > other_p.first && dim < other_p.last }
  end
end
