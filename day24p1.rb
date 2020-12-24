# frozen_string_literal: true

require 'set'
require 'active_support/all'

tiles = File.read('inputd24').split.map { |l| l.scan(/e|w|ne|nw|se|sw/) }

DELTAS = {
  e: [1, 0],
  w: [-1, 0],
  ne: [0, 1],
  nw: [-1, 1],
  se: [1, -1],
  sw: [0, -1]
}.with_indifferent_access.freeze

flipped = Set[]

tiles.each do |tile|
  x = 0
  y = 0
  tile.each do |dir|
    dx, dy = DELTAS[dir]
    x += dx
    y += dy
  end
  # p tile, [x, y]

  if flipped.include?([x, y])
    flipped.delete([x, y])
  else
    flipped.add([x, y])
  end
end

p flipped.length
