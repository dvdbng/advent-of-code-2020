# frozen_string_literal: true

cnt = File.read('inputd5').split.map do |l|
  l.tr("FBLR", "0101").to_i(2)
end.max
p cnt
