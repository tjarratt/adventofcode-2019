require 'program'
require 'instruction'
require 'nonblocking_computer'

class IntcodeComputer
  attr_reader :reader, :writer

  def initialize(reader = Queue.new, writer = Queue.new)
    @reader = reader
    @writer = writer

    @wrapped = NonblockingIntcodeComputer.new(reader, writer)
  end

  def evaluate(data)
    @wrapped.evaluate(data)

    sleep 0.000001 while @wrapped.running?
  end

  def method_missing(method, *args, &block)
    raise Exception.new("unknown method #{method}") unless valid?(method)

    @wrapped.send(method, *args, &block)
  end

  private def valid?(method)
    @wrapped.respond_to?(method)
  end
end

