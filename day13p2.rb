# frozen_string_literal: true

require 'set'
require 'active_support/all'

start, buses = "939
7,13,x,x,59,x,31,19".split
start, buses = File.read('inputd13').split
buses = buses.split(',').map.with_index { |c, i| [c.to_i, i] }.reject { |c, _i| c.zero? }

puts buses.map.with_index { |(c, off), i| "#{c}#{(97 + i).chr} = t + #{off}" }.join(" ; ")
# Input set of equations in wolfram alpha or your favourite equation solver ¯\_(ツ)_/¯
