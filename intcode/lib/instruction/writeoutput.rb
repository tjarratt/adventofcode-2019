require 'instruction/base'

module Instruction
  class WriteOutput < Base
    def initialize(input, eval_index, relative_base_setter, writer)
      @writer = writer
      super(input, eval_index, relative_base_setter)
    end

    def evaluate(program)
      value = program[index_for(1, program)]
      @writer << value

      return @eval_index + instruction_size
    end

    def instruction_size
      2
    end
  end
end
