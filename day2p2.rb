def valid?(line)
  p1, p2, char, pw = /\A(\d+)-(\d+) (.): (.*)\z/.match(line.strip).captures
  (pw[p1.to_i - 1] == char) != (pw[p2.to_i - 1] == char)
end
count = File.readlines('inputd2').count do |line|
  valid?(line)
end

p count
