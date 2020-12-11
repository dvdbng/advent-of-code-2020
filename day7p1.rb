# frozen_string_literal: true
require 'set'

contains = Hash.new { |h, k| h[k] = [] }
contained = Hash.new { |h, k| h[k] = [] }
File.read('inputd7').strip.split("\n").map do |l|
  m = /\A(\w+ \w+) bags contain (.*)\.\z/.match(l)
  color = m.captures[0]
  bags =
    if m.captures[1] == 'no other bags'
      []
    else
      m.captures[1].split(', ').map { |b| b.match(/\A(\d+) (\w+ \w+) bag/).captures }
    end
  contains[color] = bags
  bags.each { |_, containedcolor| contained[containedcolor] << color }
end
p contained

bags = Set[]
def expand(color, contained, bags)
  contained[color].each do |cc|
    next if bags.include?(cc)

    bags << cc
    expand(cc, contained, bags)
  end
end
expand('shiny gold', contained, bags)
p bags.count
