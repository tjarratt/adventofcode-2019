require 'program'
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

  def evaluate(data)
    program = Program.new(data)

    @thread = Thread.new do
      eval_index = 0
      @relative_index = 0

      while true do
        raw_op = program[eval_index]
        instruction = Instruction.for(raw_op, eval_index, @reader, @writer, method(:update_relative_base))

        Thread.exit if instruction.terminate?

        begin
          eval_index = instruction.evaluate(program)
        rescue Exception => e
          raise e
        end
      end
    end

    # explicitly return nothing so we don't leak a thread to callers
    nil
  end

  def update_relative_base(offset)
    @relative_index += offset
  end
end

