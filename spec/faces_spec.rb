require 'faces'

describe Faces do
  describe '#overlap?' do
    let(:origin) { [0, 0, 0] }
    let(:dimensions) { [4, 4, 4] }
    let(:faces) { Faces.new(origin: origin, dimensions: dimensions)}

    context 'when 2 sets of faces have 3 overlaps' do
      let(:other_origin) { [2, 2, 2] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns true' do
        expect(faces.overlap?(other_faces)).to be true
      end
    end

    context 'when a set of faces is completely within another' do
      let(:other_origin) { [1, 1, 1] }
      let(:other_dimensions) { [2, 2, 2] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: other_dimensions) }
      
      it 'returns true' do
        expect(other_faces.overlap?(faces)).to be true
      end
    end

    context 'when a set of faces is completely outside another' do
      let(:other_origin) { [1, 1, 1] }
      let(:other_dimensions) { [2, 2, 2] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: other_dimensions) }
      
      it 'returns false' do
        expect(faces.overlap?(other_faces)).to be false
      end
    end

    context 'when a set of faces is partially within another' do
      let(:other_origin) { [3, 1, 1] }
      let(:other_dimensions) { [2, 2, 2] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: other_dimensions) }
      
      it 'returns true' do
        expect(other_faces.overlap?(faces)).to be true
      end
    end

    context 'when a set of faces is partially outside another' do
      let(:other_origin) { [3, 1, 1] }
      let(:other_dimensions) { [2, 2, 2] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: other_dimensions) }
      
      it 'returns false' do
        expect(faces.overlap?(other_faces)).to be false
      end
    end

    context 'when 2 sets of faces coincide on 2 dimensions' do
      let(:other_origin) { [2, 0, 2] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns true' do
        expect(faces.overlap?(other_faces)).to be true
      end
    end

    context 'when 2 sets of faces coincide on 4 dimensions' do
      let(:other_origin) { [1, 0, 0] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns true' do
        expect(faces.overlap?(other_faces)).to be true
      end
    end

    context 'when 2 sets of faces coincide completely' do
      let(:other_origin) { [0, 0, 0] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns true' do
        expect(faces.overlap?(other_faces)).to be true
      end
    end

    context "when 2 sets of faces don't coincide at all" do
      let(:other_origin) { [8, 8, 8] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns false' do
        expect(faces.overlap?(other_faces)).to be false
      end
    end

    context "when 2 sets of faces share a dimension" do
      let(:other_origin) { [4, 0, 0] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns false' do
        expect(faces.overlap?(other_faces)).to be false
      end
    end

    context "when 2 sets of faces share a line" do
      let(:other_origin) { [4, 4, 0] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns false' do
        expect(faces.overlap?(other_faces)).to be false
      end
    end

    context "when 2 sets of faces share a point" do
      let(:other_origin) { [4, 4, 4] }
      let(:other_faces) { Faces.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns false' do
        expect(faces.overlap?(other_faces)).to be false
      end
    end
  end
end
