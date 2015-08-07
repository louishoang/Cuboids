require 'spec_helper'

describe Cuboid do
  let(:container) { Container.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }
  let(:cuboid) { Cuboid.new(origin: [2, 1, 3], dimensions: [3, 4, 5], container: container) }

  context 'when initialized without an origin, dimensions, or container' do
    it 'raises an ArgumentError' do
      expect { Cuboid.new }.to raise_error(ArgumentError)
    end
  end

  context 'when initialized with any dimension of 0 value' do
    it 'raises an ArgumentError' do
      expect { Cuboid.new(origin: [0, 0, 0], dimensions: [4, 5, 0], container: container) }.to raise_error(ArgumentError)
    end
  end

  describe '#length' do
    it 'shows the length' do
      expect(cuboid.length).to eq(3)
    end
  end

  describe '#width' do
    it 'shows the width' do
      expect(cuboid.width).to eq(4)
    end
  end

  describe '#height' do
    it 'shows the height' do
      expect(cuboid.height).to eq(5)
    end
  end

  describe '#volume' do
    it 'shows the volume' do
      expect(cuboid.volume).to eq(60)
    end
  end

  describe '#vertices_collection' do
    it 'shows the collection of vertices' do
      expect(cuboid.vertices_collection).to match_array([[2, 1, 3], [2, 1, 8], [2, 5, 3], [2, 5, 8], [5, 1, 3], [5, 1, 8], [5, 5, 3], [5, 5, 8]])
    end
  end

  describe '#faces_collection' do
    it 'shows the collection of face values' do
      expect(cuboid.faces_collection).to match_array([[1, 5], [2, 5], [3, 8]])
    end
  end

  describe '#intersects?' do
    let(:cuboid) { Cuboid.new(origin: [0, 0, 0], dimensions: [4, 4, 4], container: container) }

    context 'when 2 cuboids intersect on 3 faces' do
      let(:other_cuboid) { Cuboid.new(origin: [2, 2, 2], dimensions: [4, 4, 4], container: container) }

      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when a smaller cuboid is completely within a larger cuboid' do
      let(:other_cuboid) { Cuboid.new(origin: [8, 8, 8], dimensions: [-5, -5, -5], container: container) }

      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when a smaller cuboid is partially within a larger cuboid' do
      let(:other_cuboid) { Cuboid.new(origin: [3, 1, 1], dimensions: [2, 2, 2], container: container) }

      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when 2 cuboids align on 2 faces' do
      let(:other_cuboid) { Cuboid.new(origin: [2, 0, 2], dimensions: [4, 4, 4], container: container) }

      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when 2 cuboids align on 4 faces' do
      let(:other_cuboid) { Cuboid.new(origin: [1, 0, 0], dimensions: [4, 4, 4], container: container) }

      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context 'when 2 cuboids completely align' do
      let(:other_cuboid) { Cuboid.new(origin: [0, 0, 0], dimensions: [4, 4, 4], container: container) }

      it 'returns true' do
        expect(cuboid.intersects?(other_cuboid)).to be true
      end
    end

    context "when 2 cuboids don't intersect at all" do
      let(:other_cuboid) { Cuboid.new(origin: [8, 8, 8], dimensions: [4, 4, 4], container: container) }

      it 'returns false' do
        expect(cuboid.intersects?(other_cuboid)).to be false
      end
    end

    context "when 2 cuboids touch at a face but don't intersect" do
      let(:other_cuboid) { Cuboid.new(origin: [4, 0, 0], dimensions: [4, 4, 4], container: container) }

      it 'returns false' do
        expect(cuboid.intersects?(other_cuboid)).to be false
      end
    end

    context 'when 2 cuboids touch at an edge' do
      let(:other_cuboid) { Cuboid.new(origin: [4, 4, 0], dimensions: [4, 4, 4], container: container) }

      it 'returns false' do
        expect(cuboid.intersects?(other_cuboid)).to be false
      end
    end

    context 'when 2 cuboids touch at a corner' do
      let(:other_cuboid) { Cuboid.new(origin: [4, 4, 4], dimensions: [4, 4, 4], container: container) }

      it 'returns false' do
        expect(cuboid.intersects?(other_cuboid)).to be false
      end
    end
  end

  describe '#move_to' do
    context "when there aren't restricting boundaries or other cuboids" do
      before :each do
        cuboid.move_to(new_origin: [0, 0, 0])
      end

      it 'translates the cuboid from its initial origin to a new origin' do
        expect(cuboid.origin).to eq([0, 0, 0])
      end

      it 'translates each vertex of the cuboid to a new point' do
        expect(cuboid.vertices_collection).to match_array([[0, 0, 0], [0, 0, 5], [0, 4, 0], [0, 4, 5], [3, 0, 0], [3, 0, 5], [3, 4, 0], [3, 4, 5]])
      end

      it 'changes the face values of the cuboid' do
        expect(cuboid.faces_collection).to match_array([[0, 3], [0, 4], [0, 5]])
      end
    end

    context 'when there is a restricting boundary' do
      it 'raises an InvalidMoveError' do
        expect { cuboid.move_to(new_origin: [9, 9, 9]) }.to raise_error(InvalidMoveError)
      end
    end

    context 'when there is an obstructive cuboid' do
      let(:other_cuboid) { Cuboid.new(origin: [0, 0, 0], dimensions: [2, 2, 2], container: container) }

      it 'raises an InvalidMoveError' do
        container.add_cuboid(other_cuboid.origin, other_cuboid.dimensions)

        expect { cuboid.move_to(new_origin: [1, 1, 1]) }.to raise_error(InvalidMoveError)
      end
    end
  end

  describe '#rotate_along' do
    let(:cuboid) { Cuboid.new(origin: [4, 5, 0], dimensions: [3, 4, 5], container: container) }

    context "when there aren't restricting boundaries or other cuboids" do
      it 'rotates the cuboid 90 degrees counter-clockwise about the specified axis' do
        cuboid.rotate_along(axis: 2, clockwise: false)

        expect(cuboid.dimensions).to eq([-4, 3, 5])
      end

      it 'rotates the cuboid 90 degrees clockwise about the specified axis' do
        cuboid.rotate_along(axis: 0, clockwise: true)

        expect(cuboid.dimensions).to eq([3, -5, 4])
      end

      it 'rotates the corresponding vertices of the cuboid' do
        cuboid.rotate_along(axis: 2, clockwise: true)

        expect(cuboid.vertices_collection).to match_array([[4, 2, 0], [4, 2, 5], [4, 5, 0], [4, 5, 5], [8, 2, 0], [8, 2, 5], [8, 5, 0], [8, 5, 5]])
      end

      it 'changes the face values of the cuboid' do
        cuboid.rotate_along(axis: 2, clockwise: false)

        expect(cuboid.faces_collection).to match_array([[0, 4], [0, 5], [5, 8]])
      end
    end

    context 'when there is a restricting boundary' do
      it 'raises an InvalidMoveError' do
        expect { cuboid.rotate_along(axis: 0, clockwise: false) }.to raise_error(InvalidMoveError)
      end
    end

    context 'when there is an obstructive cuboid' do
      let(:other_cuboid) { Cuboid.new(origin: [0, 0, 0], dimensions: [3, 3, 3], container: container) }

      it 'raises an InvalidMoveError' do
        container.add_cuboid(other_cuboid.origin, other_cuboid.dimensions)

        expect { cuboid.rotate_along(axis: 1, clockwise: false) }.to raise_error(InvalidMoveError)
      end
    end
  end
end
