require 'instruction'

class IntcodeComputer
  def evaluate(program_data, reader = [], writer = [])
    eval_index = 0

    while true do
      raw_op = program_data[eval_index]
      instruction = Instruction.for(raw_op, eval_index, reader, writer)

      return program_data if instruction.terminate?

      begin
        steps = instruction.evaluate(program_data)
        eval_index += steps
      rescue Exception => e
        puts "handled exception at index #{eval_index} for op #{raw_op}"
        raise e
      end
    end
  end
end

