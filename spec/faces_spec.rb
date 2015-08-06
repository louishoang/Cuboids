require 'spec_helper'

describe Faces do
  let(:faces) { Faces.new(origin: [0, 0, 0], dimensions: [4, 4, 4])}

  describe '#collection' do
    it 'shows the collection of face values according to its origin and dimensions' do
      expect(faces.collection.length).to eq(3)
      expect(faces.collection).to match_array([[0, 4], [0, 4], [0, 4]])
    end
  end

  describe '#are_aligning_or_overlapping_with?' do
    context 'when 2 sets of faces have 3 overlaps' do
      let(:other_faces) { Faces.new(origin: [2, 2, 2], dimensions: [4, 4, 4]) }

      it 'returns true' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be true
      end
    end

    context 'when a set of faces is completely within another' do
      let(:other_faces) { Faces.new(origin: [1, 1, 1], dimensions: [2, 2, 2]) }

      it 'returns true' do
        expect(other_faces.are_aligning_or_overlapping_with?(faces)).to be true
      end
    end

    context 'when a set of faces is completely outside of another' do
      let(:other_faces) { Faces.new(origin: [1, 1, 1], dimensions: [2, 2, 2]) }

      it 'returns false' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be false
      end
    end

    context 'when a set of faces is partially within another' do
      let(:other_faces) { Faces.new(origin: [3, 1, 1], dimensions: [2, 2, 2]) }

      it 'returns true' do
        expect(other_faces.are_aligning_or_overlapping_with?(faces)).to be true
      end
    end

    context 'when a set of faces is partially outside of another' do
      let(:other_faces) { Faces.new(origin: [3, 1, 1], dimensions: [2, 2, 2]) }

      it 'returns false' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be false
      end
    end

    context 'when 2 sets of faces align on 2 dimensions' do
      let(:other_faces) { Faces.new(origin: [2, 0, 2], dimensions: [4, 4, 4]) }

      it 'returns true' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be true
      end
    end

    context 'when 2 sets of faces align on 4 dimensions' do
      let(:other_faces) { Faces.new(origin: [1, 0, 0], dimensions: [4, 4, 4]) }

      it 'returns true' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be true
      end
    end

    context 'when 2 sets of faces align completely' do
      let(:other_faces) { Faces.new(origin: [0, 0, 0], dimensions: [4, 4, 4]) }

      it 'returns true' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be true
      end
    end

    context "when 2 sets of faces don't align at all" do
      let(:other_faces) { Faces.new(origin: [8, 8, 8], dimensions: [4, 4, 4]) }

      it 'returns false' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be false
      end
    end

    context "when 2 sets of faces share a dimension" do
      let(:other_faces) { Faces.new(origin: [4, 0, 0], dimensions: [4, 4, 4]) }

      it 'returns false' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be false
      end
    end

    context "when 2 sets of faces share a line" do
      let(:other_faces) { Faces.new(origin: [4, 4, 0], dimensions: [4, 4, 4]) }

      it 'returns false' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be false
      end
    end

    context "when 2 sets of faces share a point" do
      let(:other_faces) { Faces.new(origin: [4, 4, 4], dimensions: [4, 4, 4]) }

      it 'returns false' do
        expect(faces.are_aligning_or_overlapping_with?(other_faces)).to be false
      end
    end
  end

  describe '#update' do
    context 'when given both a new origin and new dimensions' do
      it 'updates the collection of face values' do
        faces.update({ origin: [5, 6, 7], dimensions: [1, 1, 1] })

        expect(faces.collection).to match_array([[5, 6], [6, 7], [7, 8]])
      end
    end

    context 'when given only a new origin' do
      it 'updates the collection of face values according to its new origin' do
        faces.update({ origin: [1, 1, 1] })

        expect(faces.collection).to match_array([[1, 5], [1, 5], [1, 5]])
      end
    end

    context 'when given only new dimensions' do
      it 'updates the collection of face values according to its new dimensions' do
        faces.update({ dimensions: [5, 6, 7] })

        expect(faces.collection).to match_array([[0, 5], [0, 6], [0, 7]])
      end
    end
  end
end
