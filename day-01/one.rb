#!/usr/bin/env ruby

input = File.read(
  File.join(File.dirname(__FILE__), 'input.txt')
).split("\n")
  .map {|l| l.strip }
  .map {|l| l.to_f }

puts "read in #{input.size} lines, first is '#{input.first}' and the last is #{input.last}"

fuel_required = input
  .map { |mass| mass / 3 }
  .map { |mass| mass.floor }
  .map { |mass| mass - 2 }
  .inject(&:+)

puts "fuel required is #{fuel_required}"

