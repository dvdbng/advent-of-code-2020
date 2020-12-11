# frozen_string_literal: true

res = File.read('inputd6').strip.split("\n\n").map do |l|
  p l
  # p l.gsub(/[^a-z]/, '').split('').niuq.count
  p l.split.map { |sl| sl.split('').uniq }.inject(&:&).count
end.sum
p res
