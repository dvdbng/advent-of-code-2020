# frozen_string_literal: true

require 'set'

program = File.read('inputd8').strip.split("\n").map do |l|
  i, a = l.split(' ')
  [i, a.to_i]
end

program.each do |ins|
  next if ins[0] == 'acc'

  ins[0] = ins[0] == 'jmp' ? 'nop' : 'jmp'

  seen = Set[]
  acc = 0
  pc = 0
  until seen.include?(pc) || pc >= program.length
    seen << pc
    instruction, arg = program[pc]
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
  if pc >= program.length
    p 'finish'
    p acc
    break
  end
  ins[0] = ins[0] == 'jmp' ? 'nop' : 'jmp'
end
