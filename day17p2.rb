# frozen_string_literal: true

require 'set'
require "active_support/all"
map = ".#.
..#
###".split


map = "
#.#####.
#..##...
.##..#..
#.##.###
.#.#.#..
#.##..#.
#####..#
..#.#.##
".split


MARGIN = 6
MAX = map.length + MARGIN*2
map = map.map { |row| row.ljust(row.length + MARGIN, '.').rjust(MAX, '.') }
map = MARGIN.times.to_a.map { '.' * MAX } + map + MARGIN.times.to_a.map { '.' * MAX }
empty_layer = MAX.times.to_a.map { '.' * MAX }
map = (MAX/2).times.to_a.map { empty_layer.deep_dup } + [map] + (MAX/2).times.to_a.map { empty_layer.deep_dup }
empty_cube = MAX.times.to_a.map { empty_layer.deep_dup }
map = (MAX/2).times.to_a.map { empty_cube.deep_dup } + [map] + (MAX/2).times.to_a.map { empty_cube.deep_dup }


RANGE = 0...MAX

DIRS = [-1, 0, 1].product([-1, 0, 1], [-1, 0, 1], [-1, 0, 1]) - [[0, 0, 0, 0]]
def count(map, posx, posy, posz, posw, char)
  DIRS.count do |dx, dy, dz, dw|
    cx = posx + dx
    cy = posy + dy
    cz = posz + dz
    cw = posw + dw
    RANGE.include?(cx) && RANGE.include?(cy) && RANGE.include?(cz) && RANGE.include?(cw) && map[cw][cz][cy][cx] == char
  end
end

def round(map)
  new_map = map.deep_dup
  changed = false
  map.each_with_index do |cube, w|
    cube.each_with_index do |slice, z|
      slice.each_with_index do |row, y|
        row.each_char.with_index do |c, x|
          if c == '#' && [2, 3].exclude?(count(map, x, y, z, w, '#'))
            new_map[w][z][y][x] = '.'
            changed = true
          elsif c == '.' && count(map, x, y, z, w, '#') == 3
            new_map[w][z][y][x] = '#'
            changed = true
          end
        end
      end
    end
  end
  [changed, new_map]
end


changed = true
6.times { changed, map = round(map) }

count = map.sum { |cube| cube.sum { |slice| slice.sum { |row| row.count('#') } } }
p count
