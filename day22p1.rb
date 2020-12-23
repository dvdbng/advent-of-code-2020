# frozen_string_literal: true

require 'set'
require 'active_support/all'

p1, p2 = File.read('inputd22').strip.split("\n\n").map { |p| p.split.drop(2).map(&:to_i) }

while p1.length.positive? && p2.length.positive?
  c1 = p1.shift
  c2 = p2.shift
  if c1 < c2
    p2.push(c2)
    p2.push(c1)
  else
    p1.push(c1)
    p1.push(c2)
  end
end

res = (p1 + p2).reverse.map.with_index { |v, i| (i + 1) * v }.sum
p res

