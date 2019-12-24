module Instruction
  class Base
    attr_reader :param_nodes, :opcode, :eval_index, :relative_index

    def initialize(modes, eval_index, relative_index)
      @raw_modes = modes
      @eval_index = eval_index
      @relative_index = relative_index
      @param_nodes = modes.reverse
    end

    def mode_for(parameter: nil)
      raw_mode = @param_nodes[parameter - 1]

      if raw_mode == '0'
        return :position
      elsif raw_mode == '1'
        return :immediate
      elsif raw_mode == '2'
        return :relative
      else
        raise Exception.new("Unknown mode (#{raw_mode.inspect}) for parameter #{parameter}. Raw input: #{@raw_modes}")
      end
    end

    def index_for(parameter, program)
      mode = mode_for(parameter: parameter)

      if mode == :position
        return program[@eval_index + parameter]
      elsif mode == :immediate
        return @eval_index + parameter
      elsif mode == :relative
        return @relative_index + program[@eval_index + parameter]
      else
        raise Exception.new("Unknown mode #{mode}")
      end
    end

    def evaluate(*args)
      raise Exception.new('unimplemented')
    end

    def terminate?
      false
    end
  end
end
