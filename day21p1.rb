# frozen_string_literal: true

require 'set'
require 'active_support/all'

all_allergens = Set[]
all_ingredients = Set[]
input = "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)"
input = File.read('inputd21')
items = input.strip.split("\n").map do |line|
  ingredients, allergens = line.split(' (contains ')
  allergens = allergens.tr(')', '').split(', ')
  ingredients = ingredients.split
  all_allergens |= allergens
  all_ingredients |= ingredients
  [ingredients, allergens]
end

possible_allergens = Hash.new { |h, k| h[k] = all_allergens }
items.each do |ingredients, allergens|
  (all_ingredients - ingredients).each do |ingredient|
    possible_allergens[ingredient] -= allergens
  end
end


res = items.sum { |ingredients, _a| ingredients.count { |ing| possible_allergens[ing].count.zero? } }
p res
