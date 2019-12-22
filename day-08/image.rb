require 'chunky_png'

class Image
  attr_reader :layers

  def initialize(width, height, pixels)
    @layers = []
    @width = width
    @height = height

    layer_size = width * height
    index = 0

    while pixels.size > 0
      layer_input = pixels.take(layer_size)
      layers << Layer.new(layer_input, width, height)

      pixels = pixels.drop(layer_size)
      index += 1
    end
  end

  def save(path)
    image = ChunkyPNG::Image.new(@width, @height)

    coords = create_pixel_coordinates

    @layers.each_with_index do |l, index|
      coords.each do |x, y|
        image[x, y] = chunky_color_for(first_nontransparent_color(x, y))
      end
    end

    image.save(path)
  end

  private

  def create_pixel_coordinates
    coords = []
    0.upto(@width-1) { |w| 0.upto(@height-1) { |h| coords << [w, h] } }
    coords
  end

  def first_nontransparent_color(x, y)
    @layers.each_with_index do |l, index|
      color = l.color_at(x, y)
      next if color == :transparent

      return color
    end

    :transparent
  end

  def chunky_color_for(color)
    case color
    when :black
      ChunkyPNG::Color::BLACK
    when :white
      ChunkyPNG::Color::WHITE
    when :transparent
      ChunkyPNG::Color::TRANSPARENT
    else
      raise Exception.new("Unknown color ??? #{color.inspect}")
    end
  end
end

class Layer
  def initialize(pixels, width, height)
    @pixels = pixels
    @width = width
    @height = height
  end

  def how_many(pixel_value)
    @pixels.count(pixel_value)
  end

  def color_at(column, row)
    index = @width * row + column
    pixel = @pixels[index]
    case pixel
    when 0
      :black
    when 1
      :white
    when 2
      :transparent
    else
      raise Exception.new("unknown color at (#{row}, #{column}) == (index #{index}): #{pixel.inspect}")
    end
  end
end

