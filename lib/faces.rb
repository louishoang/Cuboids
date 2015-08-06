class Faces
  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
  end

  def collection
    @collection ||= build_collection
  end

  def are_aligning_or_overlapping_with?(other_faces)
    planes = [
      [yz_planes, other_faces.yz_planes],
      [xz_planes, other_faces.xz_planes],
      [xy_planes, other_faces.xy_planes]
    ]

    planes.all? { |dim| aligning_or_overlapping_between?(dim[0], dim[1]) }
  end

  def update(properties)
    properties = { origin: @origin, dimensions: @dimensions }.merge(properties)
    @origin = properties[:origin] unless @origin == properties[:origin]
    @dimensions = properties[:dimensions] unless @dimensions == properties[:dimensions]

    @collection = build_collection
  end

  protected

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

  def build_collection
    [yz_planes, xz_planes, xy_planes]
  end

  def determine_planes(idx)
    lesser_plane, greater_plane = origin[idx], origin[idx] + dimensions[idx]
    
    if lesser_plane > greater_plane 
      lesser_plane, greater_plane = greater_plane, lesser_plane
    end

    [lesser_plane, greater_plane]
  end

  def both_align?(face_planes, other_face_planes)
    [0, 1].all? { |idx| face_planes[idx] == other_face_planes[idx] }
  end

  def overlapping?(face_planes, other_face_planes)
    face_planes.any? do |dimension|
      dimension > other_face_planes[0] && dimension < other_face_planes[1]
    end
  end

  def aligning_or_overlapping_between?(face_planes, other_face_planes)
    both_align?(face_planes, other_face_planes) || overlapping?(face_planes, other_face_planes)
  end
end

