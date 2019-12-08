module Instruction

  def self.for(input, eval_index, reader, writer)
    modes, opcode = read_input(input)

    if opcode == 1
      return AdditionInstruction.new(modes, eval_index)
    elsif opcode == 2
      return MultiplicationInstruction.new(modes, eval_index)
    elsif opcode == 3
      return ReadInputInstruction.new(modes, eval_index, reader)
    elsif opcode == 4
      return WriteOutputInstruction.new(modes, eval_index, writer)
    elsif opcode == 99
      return TerminateInstruction.new
    else
      raise Exception.new("Unknown opcode #{opcode}, modes: #{modes}")
    end
  end

  def self.read_input(input)
    input = input.to_s.rjust(5, "0")

    opcode = input[3,5].to_i
    modes = input[0,3]

    return modes, opcode
  end
end

class BaseInstruction

  attr_reader :param_nodes, :opcode, :eval_index

  def initialize(modes, eval_index)
    @raw_modes = modes
    @eval_index = eval_index
    @param_nodes = modes.reverse
  end

  def mode_for(parameter: nil)
    raw_mode = @param_nodes[parameter - 1]

    if raw_mode == '0'
      return :position
    elsif raw_mode == '1'
      return :immediate
    else
      raise Exception.new("Unknown mode (#{raw_mode.inspect}) for parameter #{parameter}. Raw input: #{@raw_modes}")
    end
  end

  def index_for(parameter, program)
    mode = mode_for(parameter: parameter)

    if mode == :position
      return program[@eval_index + parameter]
    elsif mode == :immediate
      return @eval_index + parameter
    end
  end

  def evaluate(*args)
    raise Exception.new('unimplemented')
  end

  def terminate?
    false
  end
end

class AdditionInstruction < BaseInstruction
  def evaluate(program)
    a = program[index_for(1, program)]
    b = program[index_for(2, program)]
    program[index_for(3, program)] = a + b

    return instruction_size
  end

  def instruction_size
    4
  end
end

class MultiplicationInstruction < BaseInstruction
  def evaluate(program)
    a = program[index_for(1, program)]
    b = program[index_for(2, program)]
    program[index_for(3, program)] = a * b

    return instruction_size
  end

  def instruction_size
    4
  end
end

class ReadInputInstruction < BaseInstruction
  def initialize(input, eval_index, reader)
    @reader = reader
    super(input, eval_index)
  end

  def evaluate(program)
    raise Exception.new('input is empty ???') if @reader.empty?

    value = @reader.shift
    program[index_for(1, program)] = value

    return instruction_size
  end

  def instruction_size
    2
  end
end

class WriteOutputInstruction < BaseInstruction
  def initialize(input, eval_index, writer)
    @writer = writer
    super(input, eval_index)
  end

  def evaluate(program)
    value = program[index_for(1, program)]
    @writer << value

    return instruction_size
  end

  def instruction_size
    2
  end
end

class TerminateInstruction < BaseInstruction
  def initialize; end

  def evaluate(program)
    instruction_size
  end

  def instruction_size
    1
  end

  def terminate?
    true
  end
end

