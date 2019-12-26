require 'vector_normalizer'

describe VectorNormalizer do
  let(:subject) { VectorNormalizer.new }

  it 'is a no-op sometimes' do
    expect(subject.normalize(Vector.new(1, 7))).to equal Vector.new(1, 7)
    expect(subject.normalize(Vector.new(0, 0))).to equal Vector.new(0, 0)
  end

  it 'normalizes vectors to the simplest representation possible' do
    expect(subject.normalize(Vector.new(2, 2))).to(equal Vector.new(1, 1))
    expect(subject.normalize(Vector.new(4, 2))).to(equal Vector.new(2, 1))
  end

  it 'normalizes negative magnitude vectors as well' do
    expect(subject.normalize(Vector.new(-1, -1))).to equal Vector.new(-1, -1)
    expect(subject.normalize(Vector.new(-5, -5))).to equal Vector.new(-1, -1)
    expect(subject.normalize(Vector.new(0, -1))).to equal Vector.new(0, -1)
    expect(subject.normalize(Vector.new(-1, 0))).to equal Vector.new(-1, 0)
  end
end
