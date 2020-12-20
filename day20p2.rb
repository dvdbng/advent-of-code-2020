# frozen_string_literal: true

require 'set'
require 'active_support/all'

tiles = File.read('inputd20').strip.split("\n\n")

W = Integer.sqrt(tiles.length)
counter = Hash.new(0)
by_border = Hash.new { |h, k| h[k] = Set[] }

tiles = tiles.map do |tile|
  tile = tile.strip.split("\n")
  id = tile.shift[/ (\d+):/, 1].to_i
  borders = [
    tile.first,
    tile.first.reverse,
    tile.last,
    tile.last.reverse,
    tile.map(&:first).join,
    tile.map(&:first).join.reverse,
    tile.map(&:last).join,
    tile.map(&:last).join.reverse
  ]
  borders.each { |i| counter[i] += 1 }
  borders.each { |i| by_border[i] << id }

  [id, borders, tile]
end
by_id = tiles.index_by(&:first)

topleft = tiles.find do |_id, borders, _tile|
  next false unless borders.sum { |border| counter[border] } == 12

  counter[borders[0]] == 1 && counter[borders[4]] == 1
end
map = { [0, 0] => topleft.last }
used = Set[]
used << topleft.first

def rotate(tile)
  (0...tile.length).map { |i| tile.map { |row| row.split('')[i] }.join }
end

def variants(tile)
  variants = [tile]
  3.times { variants << rotate(variants.last) }
  variants += variants.map(&:reverse)
  variants += variants.map { |v| v.map(&:reverse) }
  variants
end

(1...W).each do |y|
  border = map[[0, y - 1]].last
  tile = by_border[border] - used
  raise if tile.count != 1

  variant = variants(by_id[tile.first].last).find do |v|
    v.first == border && counter[v.map(&:first).join] == 1
  end
  map[[0, y]] = variant
  used << tile.first
end

(1...W).each do |x|
  border = map[[x - 1, 0]].map(&:last).join
  tile = by_border[border] - used
  raise if tile.count != 1

  variant = variants(by_id[tile.first].last).find do |v|
    v.map(&:first).join == border && counter[v.first] == 1
  end
  map[[x, 0]] = variant
  used << tile.first

  (1...W).each do |y|
    border = map[[x, y - 1]].last
    tile = by_border[border] - used
    raise if tile.count != 1

    border2 = map[[x - 1, y]].map(&:last).join

    variant = variants(by_id[tile.first].last).find do |v|
      v.map(&:first).join == border2 && v.first == border
    end
    map[[x, y]] = variant
    used << tile.first
  end
end

bigimage = (0...W * 10).map do |y|
  tile = y / 10
  off = (y % 10) + 0
  (0...W).map { |x| map[[x, tile]][off] }.join
end

image = (0...W * 8).map do |y|
  tile = y / 8
  off = (y % 8) + 1
  (0...W).map { |x| map[[x, tile]][off][1..8] }.join
end

SM1 = /..................#./.freeze
SM2 = /#....##....##....###/.freeze
SM3 = /.#..#..#..#..#..#.../.freeze

variants(image).each_with_index do |rotimage, _rot|
  count = 0
  (1...(W * 8 - 1)).each do |y|
    line = rotimage[y]

    offset = 0

    until (index = line.index(SM2, offset)).nil?
      offset = index + 1

      count += 1 if rotimage[y - 1].index(SM1, index) == index && rotimage[y + 1].index(SM3, index) == index
    end
  end

  next unless count.positive?

  hashes = image.sum { |line| line.count('#') }
  p hashes - count * 15
  break
end

# puts map[[0, 0]].join("\n")
# puts map[[0, 1]].join("\n")
