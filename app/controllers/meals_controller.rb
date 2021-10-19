require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # get all of the meals from the meal repo
    meals = @meal_repository.all
    # give those meals to the view
    @meals_view.display(meals)
  end

  def add
    # ask user for name
    name = @meals_view.ask_for('name')
    # ask user for price
    price = @meals_view.ask_for('price').to_i
    # create an instance of a meal
    meal = Meal.new(name: name, price: price)
    # give the meal to the repository
    @meal_repository.create(meal)
  end
end
