#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'intcode', 'lib')

require 'intcode_computer'

def main
  program = read_input

  reader = Queue.new << 1
  writer = Queue.new

  computer = IntcodeComputer.new(reader, writer)
  computer.evaluate(program)
  sleep 0.000001 while computer.running?

  while !writer.empty?
    value = writer.pop
    puts "diagnostic code: #{value}" if value != 0
  end
end

def read_input
  File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split(',')
    .map(&:to_i)
end

main

