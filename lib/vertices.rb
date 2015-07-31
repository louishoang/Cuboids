class Vertices
  def initialize(origin:, dimensions:)
    @origin = origin
    @dimensions = dimensions
  end

  def collection
    @collection ||= build_collection
  end

  def update_vertices
  end

  private 

  attr_reader :origin, :dimensions

  def build_collection
    collection = Array.new(8) { Array.new }
    counter = 0
    dimension_idx = 0

    3.times do |idx|
      element_count = 2 ** (2 - idx)

      collection.each do |vertex|
        if dimension_idx == 0
          vertex << origin[idx]
        else
          vertex << origin[idx] + dimensions[idx]
        end

        if counter < element_count - 1
          counter += 1
        else
          dimension_idx = dimension_idx == 0 ? 1 : 0
          counter = 0
        end
      end
    end

    collection
  end
end


