#!/usr/bin/env ruby

# we are searching for a missing password
# It is a six-digit number.
# The value is within the range given in your puzzle input.
# Two adjacent digits are the same (like 22 in 122345).
# Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
#

def main
  range = (168630..718098).to_a
  range.map!(&:to_s)
  range.filter! { |input| is_valid_password?(input) }

  puts "There are #{range.length} valid passwords"
end

def is_valid_password?(input)
  return false if input.length != 6

  has_adjacent_digits = false

  input.split('').each_with_index do |char, index|
    break if index == input.length - 1

    prev_char = input[index - 1]
    next_char = input[index + 1]
    return false if char.to_i > next_char.to_i

    next_next_char = input[index + 2]
    has_adjacent_digits ||= char == next_char && char != next_next_char && char != prev_char
  end

  return has_adjacent_digits
end

main
