nums = File.read('input').split.map(&:to_i)
nums.each do |n1|
  nums.each do |n2|
    nums.each do |n3|
      p n1 * n2 * n3 if n1 + n2 + n3 == 2020
    end
  end
end
