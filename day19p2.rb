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
  if rule_num == 11
    r42 = to_regexp(42, rules)
    r31 = to_regexp(31, rules)
    # Regexp was a bad choice for part two because you need a push back automata to parse the grammar,
    # but since this is the only rule that needs it, we can brute force it
    parts = (1..15).to_a.map { |i| "(?:#{r42 * i})(?:#{r31 * i})" }

    return "(?:#{parts.join('|')})"
  end

  tokens = source.split.map { |token| token == '|' ? token : to_regexp(token.to_i, rules) }
  "(?:#{tokens.join('')})"
end

regexp = /\A#{to_regexp(0, rules)}\z/

cnt = messages.count { |m| regexp.match?(m) }
p cnt
