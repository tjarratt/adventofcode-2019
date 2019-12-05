#!/usr/bin/env ruby

# opscode 1 == read from next two addresses, sum them, store in third addr
# opscode 2 == read from next two addresses, multiply them, store in third addr
# opscode 99 == halt
# after each opscode move ahead FOUR positions

def main
  input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split(',')
    .map(&:to_i)

  input[1] = 12
  input[2] = 2

  output = evaluate_intcode(input)
  puts output.inspect
end

def evaluate_intcode(program)
  eval_index = 0

  while true do
    op = program[eval_index]
    if op == 1
      a = program[program[eval_index + 1]]
      b = program[program[eval_index + 2]]
      program[program[eval_index + 3]] = a + b
    elsif op == 2
      a = program[program[eval_index + 1]]
      b = program[program[eval_index + 2]]
      program[program[eval_index + 3]] = a * b
    elsif op == 99
      return program
    else
      raise "Unknown opcode #{op}"
    end

    eval_index += 4
  end
end

main

