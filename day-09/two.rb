#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'intcode', 'lib')
require 'intcode_computer'

def main
  reader = Queue.new << 2
  writer = Queue.new
  computer = IntcodeComputer.new(reader, writer)

  computer.evaluate(read_input)

  puts writer.pop.inspect
end

def read_input
  File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split(',')
    .map(&:to_i)
end

main

