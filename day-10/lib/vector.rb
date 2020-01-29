class Vector
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def equal?(other)
    return false unless other.respond_to?(:x) && other.respond_to?(:y)

    return other.x == @x && other.y == @y
  end

  def eql?(other)
    equal?(other)
  end

  def hash
    [@x, @y].hash
  end

  def length
    Math.sqrt(@x * @x + @y * @y)
  end

  def <=>(other)
    this_angle = fudge(Math.atan2(@y, @x))
    that_angle = fudge(Math.atan2(other.y, other.x))

    that_angle <=> this_angle
  end

  def to_s
    "(#{x}, #{y})"
  end

  private
  # rather than figuring out rotations (which would be SIMPLER)
  # what I've done here is figure out which quadrant we are in
  # and add an appropriately large value of PI such that the sorting works out
  def fudge(angle)
    if angle >= 0 && angle <= Math::PI/2
      angle + 4 * Math::PI
    elsif angle < 0 && angle >= -Math::PI/2
      angle + 3 * Math::PI
    elsif angle < -Math::PI/2
      angle + 2 * Math::PI
    else
      angle
    end
  end
end

#
# 3pi/4   pi/2  pi/4
#
#   pi      0    0.0
#
# -3pi/4  -pi/2  -pi /4
