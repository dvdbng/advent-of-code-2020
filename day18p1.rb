# frozen_string_literal: true

require 'set'
require 'active_support/all'

instructions = ['((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2']
instructions = File.read('inputd18').strip.split("\n")

def take!(expr)
  if expr.first == '('
    expr.shift
    res = evall!(expr)
    expr.shift
    res
  else
    expr.shift.to_i
  end
end

def evall!(expr)
  val = take!(expr)
  while !expr.empty? && expr.first != ')'
    op = expr.shift
    val = val.public_send(op, take!(expr))
  end
  val
end

tot = instructions.sum do |line|
  tokens = line.scan(/(?:\d+|[*+()])/)
  evall!(tokens)
end
p tot
