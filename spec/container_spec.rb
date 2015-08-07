require 'spec_helper'

describe Container do
  let(:container) { Container.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }

  context 'when initialized without an origin or dimensions' do
    it 'raises an ArgumentError' do
      expect { Container.new }.to raise_error(ArgumentError)
    end
  end

  context 'when initialized with any dimension of 0 value' do
    it 'raises an ArgumentError' do
      expect { Container.new(origin: [0, 0, 0], dimensions: [4, 5, 0]) }.to raise_error(ArgumentError)
    end
  end

  describe '#length' do
    it 'shows the length' do
      expect(container.length).to eq(10)
    end
  end

  describe '#width' do
    it 'shows the width' do
      expect(container.width).to eq(10)
    end
  end

  describe '#height' do
    it 'shows the height' do
      expect(container.height).to eq(10)
    end
  end

  describe '#volume' do
    it 'shows the volume' do
      expect(container.volume).to eq(1000)
    end
  end

  describe '#vertices_collection' do
    it 'shows the collection of vertices' do
      expect(container.vertices_collection).to match_array([[0, 0, 0], [0, 0, 10], [0, 10, 0], [0, 10, 10], [10, 0, 0], [10, 0, 10], [10, 10, 0], [10, 10, 10]])
    end
  end

  describe '#add_cuboid' do
    context 'when given an origin and dimensions within the container' do
      it 'adds a new cuboid into the cuboids collection' do
        container.add_cuboid([0, 0, 0], [1, 1, 1])

        expect(container.cuboids_collection.length).to eq(1)
        expect(container.cuboids_collection[0]).to be_a Cuboid
      end
    end

    context 'when given an origin and dimensions outside of the container' do
      it 'raises a StandardError' do
        expect { container.add_cuboid([11, 11, 11], [1, 1, 1]) }.to raise_error(StandardError)
      end
    end

    context 'when given an origin and dimensions within another cuboid' do
      it 'raises a StandardError' do
        container.add_cuboid([0, 0, 0], [2, 2, 2])

        expect { container.add_cuboid([1, 1, 1], [2, 2, 2]) }.to raise_error(StandardError)
      end
    end
  end

  describe '#cannot_allow_move_for?' do
    let(:existing_cuboid) { Cuboid.new(origin: [1, 1, 1], dimensions: [5, 5, 5], container: container) }

    before :each do
      container.cuboids_collection << existing_cuboid
    end

    context 'when the container finds intersecting cuboids' do
      let(:cuboid) { Cuboid.new(origin: [4, 4, 4], dimensions: [2, 2, 2], container: container) }

      it 'returns true' do
        expect(container.cannot_allow_move_for?(cuboid)).to be true
      end
    end

    context "when the container doesn't find intersecting cuboids" do
      let(:cuboid) { Cuboid.new(origin: [8, 8, 8], dimensions: [2, 2, 2], container: container) }

      it 'returns false' do
        expect(container.cannot_allow_move_for?(cuboid)).to be false
      end
    end
  end
end
