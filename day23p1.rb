# frozen_string_literal: true

require 'set'
require 'active_support/all'

cups = [3, 8, 9, 1, 2, 5, 4, 6, 7]
cups = [1, 3, 7, 8, 2, 6, 4, 9, 5]
min, max = cups.minmax
100.times do
  curr = cups.shift
  taken = cups.shift(3)
  cups.unshift(curr)

  target = cups.first
  index = nil
  loop do
    target -= 1
    target = max if target < min
    break unless (index = cups.index(target)).nil?
  end

  cups.insert(index + 1, *taken)
  cups.push(cups.shift)
end

cups.push(cups.shift) while cups.first != 1
p cups.drop(1).join('')
