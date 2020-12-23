# frozen_string_literal: true

require 'set'
require 'active_support/all'

p1, p2 = File.read('inputd22').strip.split("\n\n").map { |p| p.split.drop(2).map(&:to_i) }


def game(p1, p2, seen)
  while p1.length.positive? && p2.length.positive?
    key = p1 + [nil] + p2
    return 1 if seen.add?(key).nil?

    c1 = p1.shift
    c2 = p2.shift
    win =
      if p1.length >= c1 && p2.length >= c2
        game(p1.slice(0, c1), p2.slice(0, c2), Set[])
      elsif c2 > c1
        2
      else
        1
      end

    if win == 1
      p1.push(c1).push(c2)
    else
      p2.push(c2).push(c1)
    end
  end

  p1.length.positive? ? 1 : 2
end

game(p1, p2, Set[])
p p1, p2

res = (p1 + p2).reverse.map.with_index { |v, i| (i + 1) * v }.sum
p res
