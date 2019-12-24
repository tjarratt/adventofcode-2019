require 'instruction/addition'
require 'instruction/multiplication'
require 'instruction/readinput'
require 'instruction/writeoutput'
require 'instruction/jump_if_true'
require 'instruction/jump_if_false'
require 'instruction/less_than'
require 'instruction/equal'
require 'instruction/relative_base'
require 'instruction/terminate'

module Instruction
  def self.for(input, eval_index, reader, writer, relative_base_setter)
    modes, opcode = read_input(input)

    relative_base = relative_base_setter.call(0)

    if opcode == 1
      return Instruction::Addition.new(modes, eval_index, relative_base)
    elsif opcode == 2
      return Instruction::Multiplication.new(modes, eval_index, relative_base)
    elsif opcode == 3
      return Instruction::ReadInput.new(modes, eval_index, relative_base, reader)
    elsif opcode == 4
      return Instruction::WriteOutput.new(modes, eval_index, relative_base, writer)
    elsif opcode == 5
      return Instruction::JumpIfTrue.new(modes, eval_index, relative_base)
    elsif opcode == 6
      return Instruction::JumpIfFalse.new(modes, eval_index, relative_base)
    elsif opcode == 7
      return Instruction::LessThan.new(modes, eval_index, relative_base)
    elsif opcode == 8
      return Instruction::Equal.new(modes, eval_index, relative_base)
    elsif opcode == 9
      return Instruction::AdjustRelativeBase.new(modes, eval_index, relative_base_setter)
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

