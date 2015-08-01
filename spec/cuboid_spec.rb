require 'cuboid'

describe Cuboid do
  context 'when initialized without a specified origin' do
    it 'raises an ArgumentError' do
      expect { Cuboid.new }.to raise_error(ArgumentError)
    end
  end

  describe '#length' do
    let(:origin) { [2, 1, 3] }
    let(:dimensions) { [3, 4, 5] }
    let(:cuboid) { Cuboid.new(origin: origin, dimensions: dimensions) }

    it 'shows the length' do
      expect(cuboid.length).to eq(3)
    end
  end

  describe '#width' do
    let(:origin) { [2, 1, 3] }
    let(:dimensions) { [3, 4, 5] }
    let(:cuboid) { Cuboid.new(origin: origin, dimensions: dimensions) }

    it 'shows the width' do
      expect(cuboid.width).to eq(4)
    end
  end

  describe '#height' do
    let(:origin) { [2, 1, 3] }
    let(:dimensions) { [3, 4, 5] }
    let(:cuboid) { Cuboid.new(origin: origin, dimensions: dimensions) }

    it 'shows the height' do
      expect(cuboid.height).to eq(5)
    end
  end

  describe '#vertices' do
    let(:origin) { [2, 1, 3] }
    let(:dimensions) { [3, 4, 5] }
    let(:cuboid) { Cuboid.new(origin: origin, dimensions: dimensions) }

    it 'shows the collection of vertices according to its origin and dimensions' do
      expect(cuboid.vertices).to match_array([[2, 1, 3], [2, 1, 8], [2, 5, 3], [2, 5, 8], [5, 1, 3], [5, 1, 8], [5, 5, 3], [5, 5, 8]])
    end
  end

  describe "move_to" do
  end    
  
  describe 'intersects?' do
    let(:origin) { [0, 0, 0] }
    let(:dimensions) { [4, 4, 4] }
    let(:cuboid) { Cuboid.new(origin: origin, dimensions: dimensions) }

    context 'when 2 cuboids intersect on 3 faces' do
      let(:other_origin) { [2, 2, 2] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when a smaller cuboid is completely inside a larger cuboid' do
      let(:other_origin) { [1, 1, 1] }
      let(:other_dimensions) { [2, 2, 2] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: other_dimensions) }
      
      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when a smaller cuboid is partially inside a larger cuboid' do
      let(:other_origin) { [3, 1, 1] }
      let(:other_dimensions) { [2, 2, 2] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: other_dimensions) }
      
      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when 2 cuboids coincide on 2 faces' do
      let(:other_origin) { [2, 0, 2] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when 2 cuboids coincide on 4 faces' do
      let(:other_origin) { [1, 0, 0] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when 2 cuboids completely coincide' do
      let(:other_origin) { [0, 0, 0] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context "when 2 cuboids don't overlap at all" do
      let(:other_origin) { [8, 8, 8] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns false' do
        expect(cuboid.intersects?(other_cuboid)).to be false
      end
    end

    context "when 2 cuboids touch but don't overlap" do
      let(:other_origin) { [4, 0, 0] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns false' do
        expect(cuboid.intersects?(other_cuboid)).to be false
      end
    end

    context "when 2 cuboids touch at an edge" do
      let(:other_origin) { [4, 4, 0] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns false' do
        expect(cuboid.intersects?(other_cuboid)).to be false
      end
    end

    context "when 2 cuboids touch at a corner" do
      let(:other_origin) { [4, 4, 4] }
      let(:other_cuboid) { Cuboid.new(origin: other_origin, dimensions: dimensions) }
      
      it 'returns false' do
        expect(cuboid.intersects?(other_cuboid)).to be false
      end
    end
  end
end
