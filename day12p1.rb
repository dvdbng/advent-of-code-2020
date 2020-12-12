# frozen_string_literal: true

require 'set'
require "active_support/all"

map = %w[F10 N3 F7 R90 F11]
map = File.read('inputd12').split
x = 0
y = 0
heading = 1

DIRS = %w[N E S W].freeze


map.each do |inst|
  action = inst[0]
  arg = inst[1..-1].to_i

  action = DIRS[heading] if action == 'F'

  if action == 'N'
    y += arg
  elsif action == 'S'
    y -= arg
  elsif action == 'E'
    x += arg
  elsif action == 'W'
    x -= arg
  elsif action == 'L'
    heading = (16 + heading - arg / 90) % 4
  elsif action == 'R'
    heading = (16 + heading + arg / 90) % 4
  end
  #p inst, x, y, heading
end
p (x.abs + y.abs)
