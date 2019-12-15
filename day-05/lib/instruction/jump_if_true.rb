require 'instruction/base'

module Instruction
  class JumpIfTrue < Base
    def evaluate(program)
      a = program[index_for(1, program)]
      address = program[index_for(2, program)]

      if a != 0
        return address
      else
        return @eval_index + 3
      end
    end
  end
end

