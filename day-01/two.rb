#!/usr/bin/env ruby

input = File.read(
  File.join(File.dirname(__FILE__), 'input.txt')
).split("\n")
  .map {|l| l.strip }
  .map {|l| l.to_f }

def mass_for(fuel)
  (fuel / 3).floor - 2
end

def realistic_mass_for(fuel)
  total_fuel_needed = 0
  fuel_to_check = fuel

  while (mass = mass_for(fuel_to_check); mass > 0)
    total_fuel_needed += mass
    fuel_to_check = mass
  end

  total_fuel_needed
end

puts input
  .map { |mass| realistic_mass_for(mass) }
  .inject(&:+)

