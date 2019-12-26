require 'asteroid'

describe Asteroid do

  let(:origin) { Asteroid.new(0, 0) }
  let(:diagonal) { Asteroid.new(1, 1) }
  let(:diagonal_2) { Asteroid.new(2, 2) }

  it 'has a default visibility of zero' do
    expect(origin.visibility).to eq 0
  end

  it 'can add other visible asteroids' do
    expect(origin.is_occluded?(diagonal)).to be_falsy

    origin.add(diagonal)
    expect(origin.is_occluded?(diagonal_2)).to be_truthy
    expect(origin.visibility).to eq 1
  end

  it 'handles occlusion during adding' do
    origin.add(diagonal_2)
    expect(origin.visibility).to eq 1
    expect(origin.is_occluded?(diagonal)).to be_falsy

    origin.add(diagonal)
    expect(origin.visibility).to eq 1
  end

  it 'handles visibility of asteroids from different angles' do
    diagonal.add(origin)
    expect(diagonal.visibility).to eq 1
    expect(diagonal.is_occluded?(diagonal_2)).to be_falsy

    diagonal.add(diagonal_2)
    expect(diagonal.visibility).to eq 2
  end

  it 'visibility is commutative' do
    diagonal.add(origin)
    diagonal.add(diagonal_2)

    expect(diagonal.visibility).to eq 2
    expect(origin.visibility).to eq 1
    expect(diagonal_2.visibility).to eq 1
  end

  it 'removing visibility is commutative too' do
    origin.add(diagonal_2)
    expect(origin.visibility).to eq 1
    expect(diagonal_2.visibility).to eq 1

    origin.add(diagonal)
    expect(origin.visibility).to eq 1
    expect(diagonal.visibility).to eq 1
    expect(diagonal_2.visibility).to eq 0
  end
end
