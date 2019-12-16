#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'intcode', 'lib')
require 'intcode_computer'

def main
  program = read_input

  largest_diagnostic = -1
  permutations = (0..4).to_a.permutation.to_a
  permutations.each do |permutation|
    next_input_signal = 0

    5.times do
      reader = [permutation.shift, next_input_signal]
      writer = []

      computer = IntcodeComputer.new
      computer.evaluate(program.dup, reader, writer)

      raise Exception.new("Unexpected multiple writes: #{writer}") if writer.size > 1
      next_input_signal = writer.first
    end

    if next_input_signal > largest_diagnostic
      largest_diagnostic = next_input_signal
    end
  end

  puts largest_diagnostic
end

def read_input
  File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split(',')
    .map(&:to_i)
end

main

