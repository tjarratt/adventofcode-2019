#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'orbits'

orbit_map = construct_orbit_map('input.txt')
com = orbit_map['COM']

def count_orbits(node, counter)
  return counter if node.children.empty?

  return counter + node.children.map {|n| count_orbits(n, counter + 1) }.inject(:+)
end

total = count_orbits(com, 0)
puts total

# example ::   B => H       B => I        B => F     B => L
# example :: (1 + 2 + 3) + (2 + 3 + 4) + (4 + 5) + (5 +6 + 7)
# example :: indirect + direct == 42
