# frozen_string_literal: true

nums = File.read('inputd9').split.map(&:to_i)
target = 507622668
start = 0
fin = 0
sum = 0

loop do
  if sum == target
    p(nums[start...fin].minmax.sum)
    break
  elsif sum > target
    sum -= nums[start]
    start += 1
  elsif sum < target
    sum += nums[fin]
    fin += 1
  end
end
