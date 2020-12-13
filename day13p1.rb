# frozen_string_literal: true

require 'set'
require "active_support/all"

start, buses = "939
7,13,x,x,59,x,31,19".split
start, buses = File.read('inputd13').split
buses = buses.split(',').select { |x| x != 'x' }.map(&:to_i)
start = start.to_i

nexts = buses.map do |bus|
  nex = (start.to_f / bus).ceil * bus
  [nex, bus]
end

nex, bus = nexts.min_by(&:first)
p (nex - start) * bus
