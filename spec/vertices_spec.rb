require 'spec_helper'

describe Vertices do
  let(:vertices) { Vertices.new(origin: [2, 1, 3], dimensions: [3, 4, 5]) }

  describe '#collection' do
    it 'shows the collection of vertices according to its origin and dimensions' do
      expect(vertices.collection.length).to eq(8)
      expect(vertices.collection).to match_array([[2, 1, 3], [2, 1, 8], [2, 5, 3], [2, 5, 8], [5, 1, 3], [5, 1, 8], [5, 5, 3], [5, 5, 8]])
    end
  end

  describe '#update' do
    context 'when given both a new origin and new dimensions' do
      it 'updates the collection of vertices' do
        vertices.update({ origin: [5, 6, 7], dimensions: [1, 1, 1] })

        expect(vertices.collection).to match_array([[5, 6, 7], [5, 6, 8], [5, 7, 7], [5, 7, 8], [6, 6, 7], [6, 6, 8], [6, 7, 7], [6, 7, 8]])
      end
    end

    context 'when given only a new origin' do
      it 'updates the collection of vertices according to its new origin' do
        vertices.update({ origin: [0, 0, 0] })

        expect(vertices.collection).to match_array([[0, 0, 0], [0, 0, 5], [0, 4, 0], [0, 4, 5], [3, 0, 0], [3, 0, 5], [3, 4, 0], [3, 4, 5]])
      end
    end

    context 'when given only new dimensions' do
      it 'updates the collection of vertices according to its new dimensions' do
        vertices.update({ dimensions: [5, 6, 7] })

        expect(vertices.collection).to match_array([[2, 1, 3], [2, 1, 10], [2, 7, 3], [2, 7, 10], [7, 1, 3], [7, 1, 10], [7, 7, 3], [7, 7, 10]])
      end
    end
  end
end
