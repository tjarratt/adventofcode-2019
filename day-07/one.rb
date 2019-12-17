#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'intcode', 'lib')
require 'intcode_computer'

def main
  program = read_input

  largest_diagnostic = -1
  permutations = (0..4).to_a.permutation.to_a
  permutations.each do |permutation|
    next_signal = 0

    queues = 5.times.map { Queue.new }
    computers = 5.times.map do |index|
      reader = queues[index - 1]
      writer = queues[index]

      IntcodeComputer.new(reader, writer)
    end

    computers.each { |c| c.reader << permutation.shift }
    computers.first.reader << 0
    computers.each { |c| c.evaluate(program.dup) }
    sleep 0.1 while computers.any?(&:running?)

    next_signal = computers.last.writer.pop
    if next_signal > largest_diagnostic
      largest_diagnostic = next_signal
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

