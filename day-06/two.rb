#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'orbits'

orbit_map = construct_orbit_map('input.txt')
you = orbit_map['YOU']
santa = orbit_map['SAN']

def distance_between(start, goal, seen, counter)
  return nil if seen.include?(start)
  return counter if start.children.include?(goal)

  seen << start
  maybe = start.children
    .map {|n| distance_between(n, goal, seen, counter + 1) }
    .reject(&:nil?)

  if maybe.empty?
    return distance_between(start.parents.first, goal, seen, counter + 1)
  else
    return maybe.first
  end
end

# need to account for the fact that we don't count the distance
# from santa's orbiting body to him, hence the minus one here
puts distance_between(you, santa, [], 0) - 1

