# frozen_string_literal: true

require 'set'
require 'active_support/all'

tiles = File.read('inputd20').strip.split("\n\n")

counter = Hash.new(0)

tiles = tiles.map do |tile|
  tile = tile.strip.split("\n")
  id = tile.shift[/ (\d+):/, 1].to_i
  ids = [
    tile.first,
    tile.first.reverse,
    tile.last,
    tile.last.reverse,
    tile.map(&:first).join,
    tile.map(&:first).join.reverse,
    tile.map(&:last).join,
    tile.map(&:last).join.reverse
  ]
  ids.each { |i| counter[i] += 1 }

  [id, ids]
end

r = tiles.select do |_id, borders|
  borders.sum { |border| counter[border] } == 12
end.map(&:first).inject(:*)
p r
