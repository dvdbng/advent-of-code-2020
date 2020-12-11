# frozen_string_literal: true


all = (0..2**10).to_a

occ = File.read('inputd5').split.map do |l|
  l.tr("FBLR", "0101").to_i(2)
end
p (all - occ).sort
