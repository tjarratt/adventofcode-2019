require 'instruction'

class IntcodeComputer
  attr_reader :reader, :writer

  def initialize(reader = Queue.new, writer = Queue.new)
    @reader = reader
    @writer = writer
  end

  def running?
    @thread.status != false
  end

  def evaluate(program_data)
    @thread = Thread.new do
      eval_index = 0

      while true do
        raw_op = program_data[eval_index]
        instruction = Instruction.for(raw_op, eval_index, @reader, @writer)

        Thread.exit if instruction.terminate?

        begin
          eval_index = instruction.evaluate(program_data)
        rescue Exception => e
          puts "handled exception at index #{eval_index} for op #{raw_op}"
          raise e
        end
      end
    end

    # explicitly return nothing so we don't leak a thread to callers
    nil
  end
end

