require 'rspec'
require 'instruction'

describe 'Instructions' do
  it 'can parse the instruction 1 with position mode arguments' do
    modes, opcode = Instruction.read_input(1)

    expect(opcode).to(eq(1))
    expect(modes).to(eq('000'))
  end

  it 'can parse the instruction 1 with immediate mode arguments' do
    modes, opcode = Instruction.read_input(1101)

    expect(opcode).to(eq(1))
    expect(modes).to(eq('011'))

    instruction = Instruction.for(1101, 0, [], [])
    expect(instruction.param_nodes).to(eq('110'))

    expect(instruction.mode_for(parameter: 1)).to(eq(:immediate))
    expect(instruction.mode_for(parameter: 2)).to(eq(:immediate))
    expect(instruction.mode_for(parameter: 3)).to(eq(:position))
  end

  describe 'addition' do
    let(:instruction) { Instruction.for(1, 0, [], []) }

    it 'adds two numbers' do
      expect(instruction.is_a? Instruction::Addition).to(be_truthy)

      state = [1, 0, 0, 0]
      instruction.evaluate(state)

      expect(state).to(eq([2, 0, 0, 0]))
    end

    it 'reads its arguments correctly' do
      state = [1, 0, 0, 0]
      expect(instruction.index_for(1, state)).to(eq(0))
      expect(instruction.index_for(2, state)).to(eq(0))
      expect(instruction.index_for(3, state)).to(eq(0))
    end

    it 'advances the evaluation index by 4' do
      steps = instruction.evaluate([1, 0, 0, 0])
      expect(steps).to(eq(4))
    end
  end
end
