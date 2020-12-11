# frozen_string_literal: true

require 'set'

nums = File.read('inputd10').split.map(&:to_i).sort
nums << nums.max + 3
nums.prepend(0)
diffs = nums.each_cons(2).map { |a, b| b - a }
jumps = {
  1 => 1,
  2 => 2,
  3 => 4,
  4 => 7
}

abbr = []
curr = diffs[0]
count = 0
diffs.each do |diff|
  if diff == curr
    count += 1
  else
    abbr << [count, curr]
    count = 1
    curr = diff
  end
end
abbr << [count, curr]

total = 1
abbr.each do |c, kind|
  total *= jumps[c] if kind == 1
end
p total
