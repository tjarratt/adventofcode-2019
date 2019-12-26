require 'vector_generator'

describe VectorGenerator do

  let(:subject) { VectorGenerator.new(5, 5) }

  it 'generates the vectors for a point on a grid' do
    point = [0, 0]

    vectors = subject.generate(point)
    expect(vectors.size).to eq 21
    expect(vectors).to include [0, 1]
    expect(vectors).to include [1, 5]
    expect(vectors).to include [1, 4]
    expect(vectors).to include [1, 3]
    expect(vectors).to include [1, 2]
    expect(vectors).to include [1, 1]
    expect(vectors).to include [2, 5]
    expect(vectors).to include [2, 3]
    expect(vectors).to include [2, 1]
    expect(vectors).to include [3, 5]
    expect(vectors).to include [3, 4]
    expect(vectors).to include [3, 2]
    expect(vectors).to include [3, 1]
    expect(vectors).to include [4, 5]
    expect(vectors).to include [4, 3]
    expect(vectors).to include [4, 1]
    expect(vectors).to include [5, 4]
    expect(vectors).to include [5, 3]
    expect(vectors).to include [5, 2]
    expect(vectors).to include [5, 1]
    expect(vectors).to include [1, 0]
  end

  it 'generates vectors with negative components as well' do
    point = [5, 5]

    vectors = subject.generate(point)
    expect(vectors.size).to eq 21
    expect(vectors).to include [0, -1]
    expect(vectors).to include [-1, -5]
    expect(vectors).to include [-1, -4]
    expect(vectors).to include [-1, -3]
    expect(vectors).to include [-1, -2]
    expect(vectors).to include [-1, -1]
    expect(vectors).to include [-2, -5]
    expect(vectors).to include [-2, -3]
    expect(vectors).to include [-2, -1]
    expect(vectors).to include [-3, -5]
    expect(vectors).to include [-3, -4]
    expect(vectors).to include [-3, -2]
    expect(vectors).to include [-3, -1]
    expect(vectors).to include [-4, -5]
    expect(vectors).to include [-4, -3]
    expect(vectors).to include [-4, -1]
    expect(vectors).to include [-5, -4]
    expect(vectors).to include [-5, -3]
    expect(vectors).to include [-5, -2]
    expect(vectors).to include [-5, -1]
    expect(vectors).to include [-1, -0]
  end
end
