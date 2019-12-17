require 'instruction/base'

module Instruction
  class ReadInput < Base
    def initialize(input, eval_index, reader)
      @reader = reader
      super(input, eval_index)
    end

    def evaluate(program)
      value = @reader.shift
      program[index_for(1, program)] = value

      return @eval_index + instruction_size
    end

    def instruction_size
      2
    end
  end
end
