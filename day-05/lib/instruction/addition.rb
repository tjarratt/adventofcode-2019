require 'instruction/base'

module Instruction
  class Addition < Base
    def evaluate(program)
      a = program[index_for(1, program)]
      b = program[index_for(2, program)]
      program[index_for(3, program)] = a + b

      return @eval_index + instruction_size
    end

    def instruction_size
      4
    end
  end
end

