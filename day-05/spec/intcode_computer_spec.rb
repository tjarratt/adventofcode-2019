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
    new_program = computer.evaluate(day_2_fixture)
    expect(new_program[0]).to(eq(5482655))
  end

  it 'handles equality opcodes' do
    # if input == 8 output 1, otherwise 0
    program = [3,9,8,9,10,9,4,9,99,-1,8]
    input = [8]
    output = []

    computer.evaluate(program, input, output)
    expect(output).to(eq([1]))
  end

  it 'handles less-than opcodes' do
    # if input < 8 output 1, otherwise 0
    program = [3,9,7,9,10,9,4,9,99,-1,8]
    input = [7]
    output = []

    computer.evaluate(program, input, output)

    expect(output).to(eq [1])
  end

  it 'handles equality with immediate mode' do
    # if input == 8 output 1, otherwise 0
    program = [3,3,1108,-1,8,3,4,3,99]
    input = [8]
    output = []

    computer.evaluate(program, input, output)

    expect(output).to(eq [1])
  end

  it 'handles less-than with immediate mode' do
    # if input < 8 output 1, else 0
    program = [3,3,1107,-1,8,3,4,3,99]
    input = [7]
    output = []

    computer.evaluate(program, input, output)

    expect(output).to(eq [1])
  end

  it 'handles jump-if-false opcodes' do
    # if input == 0 then output 0 else output 1
    program = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
    input = [0]
    output = []

    computer.evaluate(program, input, output)
    expect(output).to(eq [0])
  end

  it 'handles jump-if-true opcodes' do
    # if input == 0 then output 0 else output 1
    program = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
    input = [1]
    output = []

    computer.evaluate(program, input, output)
    expect(output).to(eq [1])
  end

  it 'can use complex branching to output 999 when input less than 8' do
    input = [7]
    output = []

    computer.evaluate(complex_branch_program, input, output)

    expect(output).to(eq [999])
  end

  it 'can use complex branching to output 1000 when input equals 8' do
    input = [8]
    output = []

    computer.evaluate(complex_branch_program, input, output)

    expect(output).to(eq [1000])
  end

  it 'can use complex branching to output 1001 when output greater than 8' do
    program = complex_branch_program
    input = [9]
    output = []

    computer.evaluate(complex_branch_program, input, output)

    expect(output).to(eq [1001])
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

  let :complex_branch_program do
    [
      3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
      1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
      999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
    ]
  end
end
