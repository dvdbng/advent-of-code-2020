# frozen_string_literal: true

require 'set'
require 'active_support/all'

origcups = [3, 8, 9, 1, 2, 5, 4, 6, 7]
origcups = [1, 3, 7, 8, 2, 6, 4, 9, 5]
origcups = origcups.map { |v| v - 1 }

# arr is cupvalue => nextcupvalue
arr = (1..999_999).to_a
arr.push(0)
# arr = origcups.dup

len = arr.length
raise if len != 1_000_000

origcups.each_with_index do |v, i|
  arr[v] = if i == origcups.length - 1
             origcups.length
           else
             origcups[i + 1]
           end
end
arr[len - 1] = origcups.first
pos = origcups.first
p arr[0..11]

raise if arr.uniq.length != len

def deb(arr, pos)
  res = []
  arr.length.times do
    res << arr[pos] + 1
    pos = arr[pos]
  end
  p [res.first(10), res.last(10)]
end
# deb(arr, pos)

10_000_000.times do
  c1 = arr[pos]
  c2 = arr[c1]
  c3 = arr[c2]

  target = (pos - 1) % len
  target = (target - 1) % len while target == c2 || target == c3 || target == c1

  fin = arr[target]
  arr[pos] = arr[c3]
  arr[target] = c1
  arr[c3] = fin
  pos = arr[pos]
end

p arr[0], arr[arr[0]]
p (arr[0] + 1) * (arr[arr[0]] + 1)
