# frozen_string_literal: true

require 'set'
require "active_support/all"

rules, ticket, other_tickets = File.read('inputd16').strip.split("\n\n")
rules = rules.split("\n")
  .map { |l| /(.*): (\d+)-(\d+) or (\d+)-(\d+)/.match(l).captures }
  .map { |n, r1s, r1e, r2s, r2e| [n, r1s.to_i..r1e.to_i, r2s.to_i..r2e.to_i] }
  .index_by(&:first)


ticket = ticket.split("\n").last.split(',').map(&:to_i)
other_tickets = other_tickets.split("\n").drop(1).map { |l| l.split(',').map(&:to_i) }

valids = Set[]

rules.values.each do |_, r1, r2|
  valids.merge(r1)
  valids.merge(r2)
end

other_tickets = other_tickets.select { |t| t.all? { |i| valids.include?(i) } }

possible_fields = ([0] * ticket.length).map { rules.keys }

def remove(possible_fields, i)
  val = possible_fields[i].first
  possible_fields.each_with_index do |possible, j|
    next if j == i

    if possible.delete(val) && possible.length == 1
      remove(possible_fields, j)
    end
  end
end

other_tickets.each do |ticket|
  ticket.each_with_index do |value, i|
    next if possible_fields[i].length == 1

    possible_fields[i].select! do |field|
      rules[field][1].include?(value) || rules[field][2].include?(value)
    end

    remove(possible_fields, i) if possible_fields[i].length == 1
  end
end

res = possible_fields.map(&:first)
  .map.with_index { |v, i| [v, i] }
  .select { |v, _i| v.starts_with?('departure') }
  .map(&:last)
  .map { |i| ticket[i] }
  .inject(:*)

p res
