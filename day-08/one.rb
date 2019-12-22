#!/usr/bin/env ruby

def main
  input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split('')
    .map(&:to_i)

  puts "read in input of size #{input.size}"

  image = Image.new(25, 6, input)

  image.layers.each do |layer|
    puts "layer (#{layer.index}) has #{layer.how_many(0)} zeros"
  end

  fewest_zero_layer = image.layers.sort_by { |l| l.how_many(0) }.first

  puts "found layer with fewest zeros: #{fewest_zero_layer.how_many(0)}"
  puts fewest_zero_layer.inspect

  puts "it has #{fewest_zero_layer.how_many(1)} ones and #{fewest_zero_layer.how_many(2)} twos"
  puts fewest_zero_layer.how_many(1) * fewest_zero_layer.how_many(2)
end

class Image
  attr_reader :layers

  def initialize(width, height, pixels)
    @layers = []

    layer_size = width * height
    index = 0

    while pixels.size > 0
      layer_input = pixels.take(layer_size)
      layers << Layer.new(layer_input, index)

      pixels = pixels.drop(layer_size)
      index += 1
    end
  end
end

class Layer
  attr_reader :index

  def initialize(pixels, index)
    @pixels = pixels
    @index = index
  end

  def how_many(pixel_value)
    @pixels.count(pixel_value)
  end
end

main

