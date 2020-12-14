# frozen_string_literal: true

require 'set'
require "active_support/all"

instructions = "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0".split("\n")
instructions = File.read('inputd14').strip.split("\n")

mem = {}
mask = 0
mask_mask = 0
instructions.each do |inst|
  target, param = inst.split(' = ')
  if target == 'mask'
    mask = param.tr('X', '0').to_i(2)
    mask_mask = param.tr('01X', '001').to_i(2)
  else
    addr = target[/mem\[(\d+)\]/, 1].to_i
    mem[addr] = (param.to_i & mask_mask) | mask
  end
end
p mem.values.sum
