require 'rspec'
require 'intcode_computer'

describe 'IntcodeComputer' do
  let(:input) { Queue.new }
  let(:output) { Queue.new }
  let(:computer) { IntcodeComputer.new(input, output) }

  it 'handles equality opcodes' do
    # if input == 8 output 1, otherwise 0
    program = [3,9,8,9,10,9,4,9,99,-1,8]
    input << 8

    computer.evaluate(program)
    expect(output.pop).to(eq(1))
  end

  it 'handles less-than opcodes' do
    # if input < 8 output 1, otherwise 0
    program = [3,9,7,9,10,9,4,9,99,-1,8]
    input << 7

    computer.evaluate(program)

    expect(output.pop).to(eq 1)
  end

  it 'handles equality with immediate mode' do
    # if input == 8 output 1, otherwise 0
    program = [3,3,1108,-1,8,3,4,3,99]
    input << 8

    computer.evaluate(program)

    expect(output.pop).to(eq 1)
  end

  it 'handles less-than with immediate mode' do
    # if input < 8 output 1, else 0
    program = [3,3,1107,-1,8,3,4,3,99]
    input << 7

    computer.evaluate(program)

    expect(output.pop).to(eq 1)
  end

  it 'handles jump-if-false opcodes' do
    # if input == 0 then output 0 else output 1
    program = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
    input << 0

    computer.evaluate(program)
    expect(output.pop).to(eq 0)
  end

  it 'handles jump-if-true opcodes' do
    # if input == 0 then output 0 else output 1
    program = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
    input << 1

    computer.evaluate(program)
    expect(output.pop).to(eq 1)
  end

  it 'can use complex branching to output 999 when input less than 8' do
    input << 7

    computer.evaluate(complex_branch_program)

    expect(output.pop).to(eq 999)
  end

  it 'can use complex branching to output 1000 when input equals 8' do
    input << 8

    computer.evaluate(complex_branch_program)

    expect(output.pop).to(eq 1000)
  end

  it 'can use complex branching to output 1001 when output greater than 8' do
    program = complex_branch_program
    input << 9

    computer.evaluate(complex_branch_program)

    expect(output.pop).to(eq 1001)
  end

  it 'handles programs with intermediate mode arguments' do
    program = [1002,7,3,7,4,7,99,33]

    computer.evaluate(program)
    expect(output.pop).to(eq 99)
  end

  it 'handles programs with negative arguments' do
    program = [1101,100,-1,7,4,7,99,0]

    computer.evaluate(program)

    expect(output.pop).to(eq 99)
  end

  it 'handles read input instructions' do
    program = [3, 0, 4, 0, 99]
    input << 1
    computer.evaluate(program)

    expect(output.pop).to(eq 1)
  end

  it 'outputs large numbers using relative mode paramters' do
    program = [9, 1, 204, 4, 99, 1125899906842624]
    computer.evaluate(program)

    expect(output.pop).to(eq 1125899906842624)
  end

  it 'can output quines' do
    quine = [109, 1, 204, -1, 1001, 100, 1, 100, 1008, 100, 16, 101, 1006, 101, 0, 99]
    computer.evaluate(quine)

    full_output = []; full_output << output.pop while output.size > 0

    expect(full_output).to(eq quine)
  end

  let :complex_branch_program do
    [
      3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
      1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
      999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
    ]
  end
end
