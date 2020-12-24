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

  if flipped.include?([x, y])
    flipped.delete([x, y])
  else
    flipped.add([x, y])
  end
end

def count(map, x, y)
  DELTAS.values.count do |dx, dy|
    map.include?([x + dx, y + dy])
  end
end

map = flipped.dup
100.times do
  new_map = map.dup
  map.each do |x, y|
    cnt = count(map, x, y)
    new_map.delete([x, y]) if cnt.zero? || cnt > 2
  end

  map.each do |x, y|
    DELTAS.values.count do |dx, dy|
      pos = [x + dx, y + dy]
      new_map.add(pos) if !map.include?(pos) && !new_map.include?(pos) && count(map, x + dx, y + dy) == 2
    end
  end
  map = new_map
end
p map.count
