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
  
  describe "intersects?" do
  end
end
