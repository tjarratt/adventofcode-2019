require 'vector_normalizer'

class VectorCalculator

  def initialize(normalizer: VectorNormalizer.new)
    @normalizer = normalizer
  end

  def diff(a, b)
    vector = between(a, b)

    @normalizer.normalize(vector)
  end

  def between(a, b)
    Vector.new(b.x - a.x, b.y - a.y)
  end
end

