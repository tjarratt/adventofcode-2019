class Asteroid
  attr_reader :x, :y

  def initialize(x, y)
    @x = x; @y = y
    @visibility = 0

    @calculator = VectorCalculator.new
    @visible_asteroids = []
  end

  def is_occluded?(other)
    vector = @calculator.diff(self, other)
    length = @calculator.between(self, other).length

    @visible_asteroids.each do |asteroid|
      v_2 = @calculator.diff(self, asteroid)
      next unless vector.equal?(v_2)

      len_2 = @calculator.between(self, asteroid).length
      return true if len_2 < length
    end

    return false
  end

  def add(other)
    check_for_occlusions(other)

    other.send(:secret_add, self)

    @visible_asteroids << other
  end

  def visibility
    @visible_asteroids.size
  end

  private
  def delete(other)
    return unless @visible_asteroids.member?(other)

    secret_delete(other)
    other.send(:secret_delete, self)
  end

  def secret_delete(other)
    @visible_asteroids.delete(other)
  end

  def secret_add(other)
    @visible_asteroids.map {|a| a.send(:check_for_occlusions, other) }
    @visible_asteroids << other
  end

  def check_for_occlusions(other)
    vector = @calculator.diff(self, other)
    length = @calculator.between(self, other).length

    @visible_asteroids.each do |asteroid|
      v_2 = @calculator.diff(self, asteroid)
      next unless vector.equal?(v_2)

      len_2 = @calculator.between(self, asteroid).length
      delete(asteroid) if len_2 > length
    end
  end
end

