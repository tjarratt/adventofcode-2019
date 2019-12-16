require 'instruction/base'

module Instruction
  class Equal < Base
    def evaluate(program)
      a = program[index_for(1, program)]
      b = program[index_for(2, program)]
      address = index_for(3, program)

      result = a == b ? 1 : 0
      program[address] = result

      return @eval_index + 4
    end
  end
end
