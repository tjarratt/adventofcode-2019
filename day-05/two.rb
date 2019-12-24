#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'intcode', 'lib')

require 'intcode_computer'

def main
  program = read_input

  reader = Queue.new << 5
  writer = Queue.new

  computer = IntcodeComputer.new(reader, writer)
  computer.evaluate(program)

  puts "diagnostic code: #{writer.pop}"
end

def read_input
  File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split(',')
    .map(&:to_i)
end

main

