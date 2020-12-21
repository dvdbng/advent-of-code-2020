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
possible_ingredients = Hash.new { |h, k| h[k] = all_ingredients }

while possible_ingredients.empty? || possible_ingredients.any? { |_k, v| v.count > 1 }
  items.each do |ingredients, allergens|
    (all_ingredients - ingredients).each do |ingredient|
      possible_allergens[ingredient] -= allergens.select { |allergen| possible_ingredients[allergen].include?(ingredient) }
    end
    allergens.each do |allergen|
      possible_ingredients[allergen] &= ingredients.select { |ingredient| possible_allergens[ingredient].include?(allergen) }
      next unless possible_ingredients[allergen].count == 1

      assigned = possible_ingredients[allergen].first

      possible_ingredients.each { |k, v| v.delete(assigned) if k != allergen }
    end
  end
end

res = possible_ingredients.to_a.map { |allergen, set| [allergen, set.first] }.sort_by(&:first).map(&:last).join(',')
puts res
