require_relative '../views/orders_view'
require_relative '../views/employees_view'
require_relative '../models/order'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    # view
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def list_undelivered_orders
    # get orders from the order repo
    orders = @order_repository.undelivered_orders
    # give them to the view
    @orders_view.display(orders)
  end

  def add
    meal = build_meal
    customer = build_customer
    employee = build_rider

    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
  end

  def list_my_orders(employee)
    display_orders(employee)
  end

  def mark_as_delivered(employee)
    # list the orders for that employee
    display_orders(employee)
    # index = ask the user for the index
    index = @orders_view.ask_for('number').to_i - 1
    # give the index to the repo for all the marking stuff
    orders = @order_repository.my_undelivered_orders(employee)
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end

  private

  def display_orders(employee)
    # orders = ask the repo for my undelivered orders
    orders = @order_repository.my_undelivered_orders(employee)
    # give them to the view
    @orders_view.display(orders)
  end

  def build_meal
    # meals = get meals from meal repo
    # give those meals to the meals_view
    # index = ask user for a number
    # meal = get the meal from the meals array using the index
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @meals_view.ask_for('number').to_i - 1
    return meals[index]
  end

  def build_customer
    # customers = get customers from customer repo
    # give those customers to the customers_view
    # index = ask user for a number
    # customer = get the customer from the customers array using the index
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @customers_view.ask_for('number').to_i - 1
    return customers[index]
  end

  def build_rider
    # employees = get riders from employee repo
    # give those employees to the employees_view
    # index = ask user for a number
    # employee = get the employee from the employees array using the index
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    index = @employees_view.ask_for('number').to_i - 1
    return employees[index]
  end
end
