# frozen_string_literal: true

require 'set'

acc = 0
pc = 0
program = File.read('inputd8').strip.split("\n").map do |l|
  i, a = l.split(' ')
  [i, a.to_i]
end
seen = Set[]
until seen.include?(pc)
  seen << pc
  instruction, arg = program[pc]
  p instruction, arg
  case instruction
  when 'acc'
    acc += arg
  when 'jmp'
    pc += arg - 1
  when 'nop'
    nil
  else raise
  end
  pc += 1
end
p acc
