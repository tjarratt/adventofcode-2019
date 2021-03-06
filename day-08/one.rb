#!/usr/bin/env ruby
#
require_relative 'image'

def main
  input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split('')
    .map(&:to_i)


  image = Image.new(25, 6, input)
  fewest_zero_layer = image.layers.sort_by { |l| l.how_many(0) }.first

  puts fewest_zero_layer.how_many(1) * fewest_zero_layer.how_many(2)
end

main

