require 'rspec'
require 'intcode_computer'

describe 'IntcodeComputer' do
  let(:computer) { IntcodeComputer.new }

  it 'handles simple addition' do
    program = [1,0,0,0,99]

    new_program = computer.evaluate(program)
    expect(new_program).to(eq([2, 0, 0, 0, 99]))
  end

  it 'handles simple multiplication' do
    program = [2,3,0,3,99]

    new_program = computer.evaluate(program)
    expect(new_program).to(eq([2,3,0,6,99]))
  end

  it 'handles other multiplication' do
    program = [2,4,4,5,99,0]

    new_program = computer.evaluate(program)
    expect(new_program).to(eq([2,4,4,5,99,9801]))
  end

  it 'handles the day 2 case' do
    expect(day_2_fixture[1]).to(eq(12))
    expect(day_2_fixture[2]).to(eq(2))

    new_program = computer.evaluate(day_2_fixture)
    expect(new_program[0]).to(eq(5482655))
  end

  it 'handles programs with intermediate mode arguments' do
    program = [1002,4,3,4,33]

    new_program = computer.evaluate(program)
    expect(new_program).to(eq([1002,4,3,4,99]))
  end

  it 'handles programs with negative arguments' do
    program = [1101,100,-1,4,0]

    new_program = computer.evaluate(program)
    expect(new_program).to(eq([1101, 100, -1, 4, 99]))
  end

  it 'handles read input instructions' do
    program = [3, 255, 99]
    new_program = computer.evaluate(program, [1], [])

    expect(new_program.at(255)).to(equal(1))
  end

  let(:day_2_fixture) do
    contents = File.read(
      File.join(File.dirname(__FILE__), '../../day-02/input.txt')
    )
    program = contents
      .strip
      .split(',')
      .map(&:to_i)
    program[1] = 12
    program[2] = 2

    program
  end
end
