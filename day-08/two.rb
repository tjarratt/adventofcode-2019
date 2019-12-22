#!/usr/bin/env ruby
#
require_relative 'image'

def main
  input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))
    .strip
    .split('')
    .map(&:to_i)
  # input = [0,2,2,2,1,1,2,2,2,2,1,2,0,0,0,0]


  image = Image.new(25, 6, input)
  # image = Image.new(2, 2, input)

  image.save('tmp.png')
end

main

