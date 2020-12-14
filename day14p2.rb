# frozen_string_literal: true

require 'set'
require 'active_support/all'

instructions = "mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1".split("\n")
instructions = File.read('inputd14').strip.split("\n")

mem = {}
mask = 0
mask_mask = 0
masks = []
instructions.each do |inst|
  target, param = inst.split(' = ')
  if target == 'mask'
    mask = param.tr('X', '0').to_i(2)
    mask_mask = param.tr('01X', '001').to_i(2)
    bits = param.split('')
                .reverse
                .map.with_index { |c, i| [c, i] }
                .select { |c, _i| c == 'X' }
                .map(&:last)

    masks = (0..(bits.length)).to_a.map do |i|
      bits.combination(i).map do |arr|
        arr.map { |n| 1 << n }.inject(0, &:|)
      end
    end.flatten
  else
    addr = (target[/mem\[(\d+)\]/, 1].to_i | mask) & ~mask_mask
    value = param.to_i

    masks.each do |m|
      mem[addr | m] = value
    end
  end
end
p mem.values.sum
