require 'vector'

class VectorNormalizer
  def normalize(vector)
    x, y = gcd(vector.x, vector.y)

    return Vector.new(x, y)
  end

  private def gcd(x, y)
    if x == 0 && y == 0
      return [x, y]
    elsif x == 0
      return [x, y > 0 ? 1 : -1]
    elsif y == 0
      return [x > 0 ? 1 : -1, y]
    end

    if x < y
      return [x, y] if x.gcd(y) == 1
      return [x / x.gcd(y), y / x.gcd(y)]
    else
      return [x, y] if y.gcd(x) == 1
      return [x / y.gcd(x), y / y.gcd(x)]
    end
  end
end

