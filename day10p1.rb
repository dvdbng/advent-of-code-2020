# frozen_string_literal: true

require 'set'

nums = File.read('inputd10').split.map(&:to_i).sort
nums << nums.max + 3
nums.prepend(0)
diffs = nums.each_cons(2).map { |a, b| b - a }

counts = Hash.new(0)
diffs.each { |k| counts[k] += 1 }
p counts[1] * counts[3]

