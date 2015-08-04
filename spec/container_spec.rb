require 'container'

describe Container do
  context 'when initialized without a specified origin' do
    it 'raises an ArgumentError' do
      expect { Container.new }.to raise_error(ArgumentError)
    end
  end

  describe '#length' do
    let(:container) { Container.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }

    it 'shows the length' do
      expect(container.length).to eq(10)
    end
  end

  describe '#width' do
    let(:container) { Container.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }

    it 'shows the width' do
      expect(container.width).to eq(10)
    end
  end

  describe '#height' do
    let(:container) { Container.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }

    it 'shows the height' do
      expect(container.height).to eq(10)
    end
  end

  describe '#vertices' do
    let(:container) { Container.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }

    it 'shows the collection of vertices according to its origin and dimensions' do
      expect(container.vertices).to match_array([[0, 0, 0], [0, 0, 10], [0, 10, 0], [0, 10, 10], [10, 0, 0], [10, 0, 10], [10, 10, 0], [10, 10, 10]])
    end
  end

  describe '#intersects?' do
    let(:container) { Container.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }

    context 'when a cuboid intersects the container on 3 faces' do
      let(:cuboid) { Cuboid.new(origin: [9, 9, 9], dimensions: [5, 5, 5]) }

      it 'returns true' do
        expect(container.intersects?(cuboid)).to be true
      end
    end

    context 'when a cuboid is completely within the container' do
      let(:cuboid) { Cuboid.new(origin: [1, 1, 1], dimensions: [2, 2, 2]) }

      it 'returns false' do
        expect(container.intersects?(cuboid)).to be false
      end
    end

    context 'when a cuboid is completely outside the container' do
      let(:cuboid) { Cuboid.new(origin: [11, 11, 11], dimensions: [1, 1, 1]) }

      it 'returns true' do
        expect(container.intersects?(cuboid)).to be true
      end
    end

    context 'when a cuboid partially juts out of a container' do
      let(:cuboid) { Cuboid.new(origin: [9, 5, 5], dimensions: [2, 2, 2]) }

      it 'returns true' do
        expect(container.intersects?(cuboid)).to be true
      end
    end

    context 'when a cuboid touches the container from the outside' do
      let(:cuboid) { Cuboid.new(origin: [10, 0, 0], dimensions: [2, 2, 2]) }

      it 'returns true' do
        expect(container.intersects?(cuboid)).to be true
      end
    end

    context 'when a cuboid completely occupies a container' do
      let(:cuboid) { Cuboid.new(origin: [0, 0, 0], dimensions: [10, 10, 10]) }

      it 'returns false' do
        expect(container.intersects?(cuboid)).to be false
      end
    end

    context "when a cuboid partially occupies a container at an edge" do
      let(:cuboid) { Cuboid.new(origin: [4, 0, 0], dimensions: [4, 4, 4]) }

      it 'returns false' do
        expect(container.intersects?(cuboid)).to be false
      end
    end

    context "when a cuboid touches an edge of a container on the outside" do
      let(:cuboid) { Cuboid.new(origin: [10, 5, 10], dimensions: [1, 1, 1]) }

      it 'returns true' do
        expect(container.intersects?(cuboid)).to be true
      end
    end

    context "when a cuboid touches a corner of a container on the outside" do
      let(:cuboid) { Cuboid.new(origin: [10, 10, 10], dimensions: [1, 1, 1]) }

      it 'returns true' do
        expect(container.intersects?(cuboid)).to be true
      end
    end
  end
end
