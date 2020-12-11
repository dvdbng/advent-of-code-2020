count = File.readlines('inputd2').count do |line|
  start, fin, char, pw = /\A(\d+)-(\d+) (.): (.*)\z/.match(line.strip).captures
  range = start.to_i..fin.to_i
  range.include?(pw.count(char))
end

p count
