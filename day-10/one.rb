#!/usr/bin/env ruby

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'asteroid_puzzle_solver'

fixture = File.read(File.join(File.dirname(__FILE__), 'input.txt'))

solver = AsteroidPuzzleSolver.new
solution = solver.solve(fixture)

puts solution.inspect

