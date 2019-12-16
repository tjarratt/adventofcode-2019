#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'intcode', 'lib')

require 'intcode_computer'

def main
  program = read_input

  reader = [5]
  writer = []

  computer = IntcodeComputer.new
  new_program = computer.evaluate(program, reader, writer)

  puts "diagnostic code: #{writer.last}"
end

def read_input
  File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split(',')
    .map(&:to_i)
end

main

