require 'vector_normalizer'

class VectorGenerator
  def initialize(width, height, normalizer: VectorNormalizer.new)
    @width = width; @height = height

    @normalizer = normalizer
  end

  def generate(point)
    px, py = point

    vectors = []
    w = w_floor(px).upto(w_ceil(px))
    h = h_floor(py).upto(h_ceil(py))

    w.each do |x|
      h.each do |y|
        vectors << Vector.new(x, y)
      end
    end

    vectors
      .map { |v| @normalizer.normalize(v) }
      .map { |v| [v.x, v.y] }
      .uniq
      .keep_if { |v| v != [0, 0] }
      .sort
  end

  def w_ceil(x)
    @width - x
  end

  def h_ceil(y)
    @height - y
  end

  def w_floor(x)
    -x
  end

  def h_floor(y)
    -y
  end
end

