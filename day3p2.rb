# frozen_string_literal: true

map = File.read('inputd3').split

slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]

slp = slopes.map do |dx, dy|
  map.select.with_index { |_, n| (n % dy).zero? }.each_with_index.count do |line, rown|
    pos = (rown * dx) % line.length
    line[pos] == '#'
  end
end

p slp.inject(:*)
