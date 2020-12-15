# frozen_string_literal: true

require 'set'
require "active_support/all"

nums = [0, 3, 6]
nums = [1, 3, 2]
nums = [2, 1, 3]
nums = [2, 0, 1, 7, 4, 14, 18]

last = {}
prev = 0
prevprev = 0
#2020.times do |i|
30000000.times do |i|
  prevprev = prev
  if i < nums.length
    prev = nums[i]
  elsif last.key?(prev)
    sec = i - last[prev] - 1
    prev = sec
  else
    prev = 0
  end
  last[prevprev] = i - 1 if i >= 1
end
p prev
