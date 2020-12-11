# frozen_string_literal: true

req = %w[byr iyr eyr hgt hcl ecl pid]

rules = {
  'byr' => /\A(19[2-8][0-9]|199[0-9]|200[0-2])\z/,
  'iyr' => /\A(201[0-9]|2020)\z/,
  'eyr' => /\A(202[0-9]|2030)\z/,
  'hgt' => /\A0*((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)\z/,
  'hcl' => /\A#[0-9a-f]{6}\z/,
  'ecl' => /\A(amb|blu|brn|gry|grn|hzl|oth)\z/,
  'pid' => /\A\d{9}\z/
}

cnt = File.read('inputd4').strip.split("\n\n").count do |pp|
  fields = pp.split.map { |f| f.split(':', 2) }

  (fields.map(&:first) & req).count == req.count &&
    fields.all? do |field, value|
      p field, value
      !rules.include?(field) ||
        rules[field].match?(value)
    end
end
p cnt
