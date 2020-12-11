map = File.read('inputd3').split
cnt = map.each_with_index.count do |line, rown|
  pos = (rown * 3) % line.length
  line[pos] == "#"
end
p cnt
