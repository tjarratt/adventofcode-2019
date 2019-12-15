require 'instruction/addition'
require 'instruction/multiplication'
require 'instruction/readinput'
require 'instruction/writeoutput'
require 'instruction/terminate'

module Instruction
  def self.for(input, eval_index, reader, writer)
    modes, opcode = read_input(input)

    if opcode == 1
      return Instruction::Addition.new(modes, eval_index)
    elsif opcode == 2
      return Instruction::Multiplication.new(modes, eval_index)
    elsif opcode == 3
      return Instruction::ReadInput.new(modes, eval_index, reader)
    elsif opcode == 4
      return Instruction::WriteOutput.new(modes, eval_index, writer)
    elsif opcode == 99
      return Instruction::Terminate.new
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

