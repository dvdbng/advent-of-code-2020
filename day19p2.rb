# frozen_string_literal: true

require 'set'
require 'active_support/all'

instructions = ['((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2']
rules, messages = File.read('inputd19').strip.split("\n\n")
messages = messages.strip.split("\n")
rules = rules.strip.split("\n").map do |line|
  num, rule = line.split(': ')
  [num.to_i, rule]
end.to_h
#rules[8] = '42 | 42 8'
#rules[11] = '42 31 | 42 11 31'

def to_regexp(rule_num, rules)
  source = rules[rule_num]
  return source[1] if source.starts_with?('"')
  return "#{to_regexp(42, rules)}+" if rule_num == 8
  return "(?<r11>#{to_regexp(42, rules)}\\g<r11>?#{to_regexp(31, rules)})" if rule_num == 11

  tokens = source.split.map { |token| token == '|' ? token : to_regexp(token.to_i, rules) }
  "(?:#{tokens.join('')})"
end

regexp = /\A#{to_regexp(0, rules)}\z/

cnt = messages.count { |m| regexp.match?(m) }
p cnt
