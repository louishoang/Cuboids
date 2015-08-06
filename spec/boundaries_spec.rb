require 'spec_helper'

describe Boundaries do
  describe '#has_outside_or_overlapping?' do
    let(:boundaries) { Boundaries.new(origin: [0, 0, 0], dimensions: [10, 10, 10])}

    context 'when a set of boundaries has 3 overlaps with a set of faces' do
      let(:faces) { Faces.new(origin: [9, 9, 9], dimensions: [2, 2, 2]) }

      it 'returns true' do
        expect(boundaries.has_outside_or_overlapping?(faces)).to be true
      end
    end

    context 'when a set of faces is completely within a set of boundaries' do
      let(:faces) { Faces.new(origin: [1, 1, 1], dimensions: [2, 2, 2]) }

      it 'returns false' do
        expect(boundaries.has_outside_or_overlapping?(faces)).to be false
      end
    end

    context 'when a set of faces is completely outside of a set of boundaries' do
      let(:faces) { Faces.new(origin: [11, 11, 11], dimensions: [1, 1, 1]) }

      it 'returns true' do
        expect(boundaries.has_outside_or_overlapping?(faces)).to be true
      end
    end

    context 'when a set of faces is touching a boundary from the outside' do
      let(:faces) { Faces.new(origin: [10, 0, 0], dimensions: [2, 2, 2]) }

      it 'returns true' do
        expect(boundaries.has_outside_or_overlapping?(faces)).to be true
      end
    end

    context 'when a set of faces is touching 2 boundaries from the inside' do
      let(:faces) { Faces.new(origin: [0, 0, 0], dimensions: [2, 2, 2]) }

      it 'returns false' do
        expect(boundaries.has_outside_or_overlapping?(faces)).to be false
      end
    end

    context 'when a set of faces aligns completely with the set of boundaries' do
      let(:faces) { Faces.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }

      it 'returns false' do
        expect(boundaries.has_outside_or_overlapping?(faces)).to be false
      end
    end
  end
end
