require 'instruction/base'

module Instruction
  class JumpIfFalse < Base
    def evaluate(program)
      parameter = program[index_for(1, program)]
      address = program[index_for(2, program)]

      if parameter == 0
        return address
      else
        return @eval_index + 3
      end
    end
  end
end

