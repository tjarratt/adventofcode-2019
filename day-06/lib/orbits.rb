class Node
  attr_reader :name, :children, :parents

  def initialize(name)
    @name = name
    @children = []
    @parents = []
  end
end

def construct_orbit_map(filename)
  input_path = File.join(File.dirname(__FILE__), '..', filename)
  map_data = File.read(input_path)
    .strip
    .split("\n")
    .map {|l| l.split(')') }

  orbit_map = {}

  map_data.each do |body, child|
    raise "BLOODY HELL #{body.inspect} #{child.inspect}" if body.nil? or child.nil?

    parent_node = orbit_map.fetch(body, Node.new(body))
    child_node = orbit_map.fetch(child, Node.new(child))

    parent_node.children << child_node
    child_node.parents << parent_node

    orbit_map[body] ||= parent_node
    orbit_map[child] ||= child_node
  end

  orbit_map
end
