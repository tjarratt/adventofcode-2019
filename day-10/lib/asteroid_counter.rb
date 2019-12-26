require 'asteroid'
require 'vector_calculator'

class AsteroidCounter

  attr_reader :asteroids

  def initialize(calculator: VectorCalculator.new)
    @asteroids = {}
    @calculator = calculator
  end

  def add_asteroid(x: 0, y: 0)
    new_asteroid = Asteroid.new(x, y)

    @asteroids.each do |position, asteroid|
      next if asteroid.is_occluded?(new_asteroid)

      asteroid.add(new_asteroid)
    end

    @asteroids[[x, y]] = new_asteroid
  end

  def visibility_at(x: 0, y: 0)
    return 0 unless @asteroids.member?([x, y])

    return @asteroids[[x, y]].visibility
  end

  def asteroids
    @asteroids.size
  end

  def most_visible
    best = @asteroids
      .map { |pos, asteroid| [*pos, asteroid.visibility] }
      .sort_by { |lump| lump.last }
      .last

    puts "most visible ? #{best.inspect}"
    best.pop
    best
  end
end

