# frozen_string_literal: true

require 'set'
require 'active_support/all'

instructions = ['1 + 2 * 3 + 4 * 5 + 6']
instructions = ['((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2']
instructions = File.read('inputd18').strip.split("\n")

def eval_op(stack)
  a = stack.pop
  op = stack.pop
  b = stack.pop
  stack << a.public_send(op, b)
end

def evall!(expr)
  stack = []
  expr.each do |token|
    if token == ')'
      eval_op(stack) while stack.second_to_last != '('
      res = stack.pop
      stack.pop
      stack << res
    elsif ['*', '+', '('].include?(token)
      stack << token
    else
      stack << token.to_i
    end

    eval_op(stack) while stack.second_to_last == '+' && stack.last != '('
  end

  eval_op(stack) while stack.length > 1
  stack.shift
end

tot = instructions.sum do |line|
  tokens = line.scan(/(?:\d+|[*+()])/)
  evall!(tokens)
end
p tot
