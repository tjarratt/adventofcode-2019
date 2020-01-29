require 'asteroid_counter'

class AsteroidPuzzleSolver

  attr_reader :numbered_grid

  def initialize(counter: AsteroidCounter.new)
    @counter = counter
  end

  def solve(input)
    grid = input.split("\n").map {|l| l.split('') }
    @grid = grid

    grid.each_with_index do |line, y|
      line.each_with_index do |char, x|
        next unless char == '#'

        @counter.add_asteroid(x: x, y: y)
      end
    end

    @counter.most_visible
  end
end

