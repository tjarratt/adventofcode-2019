require 'asteroid_counter'

describe AsteroidCounter do

  let(:subject) { AsteroidCounter.new }

  it 'determines the visibility of asteroids' do
    subject.add_asteroid(x: 0, y: 0)
    subject.add_asteroid(x: 1, y: 1)
    subject.add_asteroid(x: 2, y: 2)

    expect(subject.asteroids).to(eq 3)
    expect(subject.visibility_at(x: 0, y: 0)).to eq 1
    expect(subject.visibility_at(x: 1, y: 1)).to eq 2
    expect(subject.visibility_at(x: 2, y: 2)).to eq 1

    expect(subject.most_visible).to eq [1, 1]
  end

  it 'has some edgecases, I guess ?' do
    subject.add_asteroid(x: 0, y: 0)
    subject.add_asteroid(x: 1, y: 0)

    expect(subject.visibility_at(x: 0, y: 0)).to eq 1
    expect(subject.visibility_at(x: 1, y: 0)).to eq 1

    subject.add_asteroid(x: 2, y: 0)

    expect(subject.visibility_at(x: 0, y: 0)).to eq 1
    expect(subject.visibility_at(x: 1, y: 0)).to eq 2
    expect(subject.visibility_at(x: 2, y: 0)).to eq 1
  end
end


