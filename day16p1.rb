# frozen_string_literal: true

require 'set'
require "active_support/all"

rules, ticket, other_tickets = File.read('inputd16').strip.split("\n\n")
rules = rules.split("\n")
  .map { |l| /(.*): (\d+)-(\d+) or (\d+)-(\d+)/.match(l).captures }
  .map { |n, r1s, r1e, r2s, r2e| [n, r1s.to_i..r1e.to_i, r2s.to_i..r2e.to_i] }

ticket = ticket.split("\n").last.split(',').map(&:to_i)
other_tickets = other_tickets.split("\n").drop(1).map { |l| l.split(',').map(&:to_i) }

valids = Set[]

rules.each do |_, r1, r2|
  valids.merge(r1)
  valids.merge(r2)
end

tot = other_tickets.flatten.reject { |i| valids.include?(i) }.sum
