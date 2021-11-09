require 'csv'
require_relative '../models/meal'
require_relative 'base_repository'

class MealRepository < BaseRepository
  def find(id)
    @elements.find { |meal| meal.id == id } # instance or nil
  end

  private

  def build_instance(attributes)
    attributes[:id] = attributes[:id].to_i
    attributes[:price] = attributes[:price].to_i
    Meal.new(attributes)
  end
end
