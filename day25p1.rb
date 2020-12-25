# frozen_string_literal: true

require 'set'
require 'active_support/all'

nums = [5_764_801, 17_807_724]
nums = [14_788_856, 19_316_454]
DIV = 20_201_227
SUBJECT_INITIAL = 7

def find_loop(num)
  val = 1
  n = 0
  while val != num
    val *= SUBJECT_INITIAL
    val = val % DIV
    n += 1
  end
  n
end


loopn = find_loop(nums.first)
val = 1
loopn.times do
  val *= nums.last
  val = val % DIV
end
p val

