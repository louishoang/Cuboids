class Vertices
  attr_reader :origin, :dimensions

  def initialize(origin:, dimensions:)
    @origin, @dimensions = origin, dimensions
  end

  def collection
    @collection ||= build_collection
  end

  def update(props)
    props = { origin: origin, dimensions: dimensions }.merge(props)
    @origin = props[:origin] unless origin == props[:origin]
    @dimensions = props[:dimensions] unless dimensions == props[:dimensions]
    @collection = build_collection
  end

  private

  def build_collection(counter = 0, dimension_idx = 0)
    collection = Array.new(8) { Array.new }

    3.times do |idx|
      element_count = 2 ** (2 - idx) # 4, 2, 1

      collection.each do |vertex|
        if dimension_idx == 0
          vertex << @origin[idx]
        else
          vertex << @origin[idx] + @dimensions[idx]
        end

        if counter < element_count - 1
          counter += 1
        else
          dimension_idx = (dimension_idx + 1) % 2
          counter = 0
        end
      end
    end

    collection
  end
end
