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
        debug!
      end
    end

    debug!

    @counter.most_visible
  end

  private
  def debug!
    return

    build_numbered_grid!

    puts ""
    puts ""
    puts "DEBUG"
    puts "====="
    @numbered_grid.map {|l| l.join('') }.each {|l| puts l }
    puts ""
  end

  def build_numbered_grid!
    @numbered_grid = []

    @grid.each_with_index do |line, y|
      @numbered_grid << []
      line.each_with_index do |char, x|
        if char == '.'
          @numbered_grid[y][x] = '.'
        else
          @numbered_grid[y][x] = @counter.visibility_at(x: x, y: y)
        end
      end
    end
  end
end

