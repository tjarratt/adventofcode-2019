#!/usr/bin/env ruby

input_path = File.join(File.dirname(__FILE__), 'input.txt')
map_data = File.read(input_path)
  .strip
  .split("\n")
  .map {|l| l.split(')') }

class Node
  attr_reader :name, :children

  def initialize(name)
    @name = name
    @children = []
  end
end

orbit_map = {}

map_data.each do |body, child|
  raise "BLOODY HELL #{body.inspect} #{child.inspect}" if body.nil? or child.nil?

  parent_node = orbit_map.fetch(body, Node.new(body))
  child_node = orbit_map.fetch(child, Node.new(child))

  parent_node.children << child_node

  orbit_map[body] ||= parent_node
  orbit_map[child] ||= child_node
end

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
