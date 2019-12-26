require 'asteroid_puzzle_solver'

describe AsteroidPuzzleSolver do
  let(:subject) { AsteroidPuzzleSolver.new }

  it 'can solve the simplest one' do
    fixture = read(fixture: '1')

    solution = subject.solve(fixture)

    expect(solution).to eq [3, 4]
  end

  it 'can solve the second simplest case' do
    solution = subject.solve(read(fixture: '2'))

    expect(solution).to eq [5, 8]
  end

  it 'can solve the THIRD simplest case' do
    solution = subject.solve(read(fixture: '3'))

    expect(solution).to eq [1, 2]
  end

  it 'can solve the FOURTH simplest case' do
    solution = subject.solve(read(fixture: '4'))

    expect(solution).to eq [6, 3]
  end

  it 'can solve the FIFTH and most complex case yet' do
    solution = subject.solve(read(fixture: '5'))

    expect(solution).to eq [11, 13]
  end
end

def read(fixture: nil)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', fixture))
end
