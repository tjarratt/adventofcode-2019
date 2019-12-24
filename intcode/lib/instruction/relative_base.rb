require 'instruction/base'

module Instruction
  class AdjustRelativeBase < Base
    def initialize(modes, eval_index, relative_base_setter)
      @relative_base_setter = relative_base_setter
      super(modes, eval_index, relative_base_setter.call(0))
    end

    def evaluate(program)
      base_offset = program[index_for(1, program)]
      @relative_base_setter.call(base_offset)

      return @eval_index + 2
    end
  end
end

