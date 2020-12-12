# frozen_string_literal: true

require 'set'
require "active_support/all"

map = %w[F10 N3 F7 R90 F11]
map = File.read('inputd12').split
x = 0
y = 0
wx = 10
wy = 1

map.each do |inst|
  action = inst[0]
  arg = inst[1..-1].to_i

  if action == 'F'
    x += wx * arg
    y += wy * arg
  elsif action == 'N'
    wy += arg
  elsif action == 'S'
    wy -= arg
  elsif action == 'E'
    wx += arg
  elsif action == 'W'
    wx -= arg
  elsif action == 'L'
    (arg / 90).times { wx, wy = [-wy, wx] }
  elsif action == 'R'
    (arg / 90).times { wx, wy = [wy, -wx] }
  end
end
p (x.abs + y.abs)
