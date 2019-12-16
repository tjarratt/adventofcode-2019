require 'instruction/base'

module Instruction
  class Terminate < Base
    def initialize; end

    def evaluate(program)
      @eval_index + instruction_size
    end

    def instruction_size
      1
    end

    def terminate?
      true
    end
  end
end
