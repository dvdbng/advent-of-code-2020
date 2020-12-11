# frozen_string_literal: true

require 'set'

nums = File.read('inputd9').split.map(&:to_i)
numset = nums.take(25)
nums.drop(25).each do |n|
  p(n) unless numset.combination(2).any? { |a, b| a + b == n }
  numset.shift
  numset.push(n)
end
