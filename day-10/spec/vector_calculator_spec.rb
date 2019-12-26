require 'vector_calculator'
require 'asteroid'

describe VectorCalculator do
  let(:subject) { VectorCalculator.new }

  let(:asteroid_a) { Asteroid.new(1, 1) }
  let(:asteroid_b) { Asteroid.new(2, 1) }
  let(:asteroid_c) { Asteroid.new(2, 2) }
  let(:asteroid_d) { Asteroid.new(1, 2) }

  it 'calculates the vector between two asteroids' do
    expect(subject.diff(asteroid_a, asteroid_a)).to equal(Vector.new(0, 0))
    expect(subject.diff(asteroid_a, asteroid_b)).to equal(Vector.new(1, 0))
    expect(subject.diff(asteroid_a, asteroid_c)).to equal(Vector.new(1, 1))
    expect(subject.diff(asteroid_a, asteroid_d)).to equal(Vector.new(0, 1))

    expect(subject.diff(asteroid_c, asteroid_a)).to equal(Vector.new(-1, -1))
    expect(subject.diff(asteroid_c, asteroid_b)).to equal(Vector.new(0, -1))
    expect(subject.diff(asteroid_c, asteroid_c)).to equal(Vector.new(0, 0))
    expect(subject.diff(asteroid_c, asteroid_d)).to equal(Vector.new(-1, 0))
  end

  it 'normalizes the vector when possible' do
    origin = Vector.new(0, 0)
    diagonal = Vector.new(1, 1)
    diagonal_2 = Vector.new(2, 2)

    expect(subject.diff(origin, diagonal)).to equal(Vector.new(1, 1))
    expect(subject.diff(origin, diagonal_2)).to equal(Vector.new(1, 1))

    expect(subject.between(origin, diagonal)).to equal(Vector.new(1, 1))
    expect(subject.between(origin, diagonal_2)).to equal(Vector.new(2, 2))
  end
end
