# frozen_string_literal: true

require 'set'
require "active_support/all"

map = "
#.##.##.##
#######.##
#.#.#..#..
####.##.##
#.##.##.##
#.#####.##
..#.#.....
##########
#.######.#
#.#####.##".split
map = File.read('inputd11').split
W = map.first.length
H = map.length
DIRS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
def count(map, posx, posy, char)
  DIRS.count do |dx, dy|
    cx = posx + dx
    cy = posy + dy
    cx >= 0 && cx < W && cy >= 0 && cy < H && map[cy][cx] == char
  end
end

def round(map)
  new_map = map.deep_dup
  changed = false
  map.each_with_index do |row, y|
    row.each_char.with_index do |c, x|
      if c == 'L' && count(map, x, y, '#').zero?
        new_map[y][x] = '#'
        changed = true
      elsif c == '#' && count(map, x, y, '#') >= 4
        new_map[y][x] = 'L'
        changed = true
      end
    end
  end
  [changed, new_map]
end


changed = true
changed, map = round(map) while changed

count = map.map { |row| row.count('#') }.sum
p count
