require 'vertices'

describe Vertices do
  describe '#collection' do
    let(:origin) { [2, 1, 3] }
    let(:dimensions) { [3, 4, 5] }
    let(:vertices) { Vertices.new(origin: origin, dimensions: dimensions) }

    it 'shows the collection  of vertices according to its origin and dimensions' do
      expect(vertices.collection).to match_array([[2, 1, 3], [2, 1, 8], [2, 5, 3], [2, 5, 8], [5, 1, 3], [5, 1, 8], [5, 5, 3], [5, 5, 8]])
    end
  end
end
