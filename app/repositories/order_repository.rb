require 'csv'
require_relative '../models/order'
require_relative 'base_repository'

class OrderRepository < BaseRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    super(csv_file_path)
  end

  def undelivered_orders
    @elements.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select { |order| order.employee == employee }
  end

  def mark_as_delivered(order)
    # change the status of the order
    order.deliver!
    # save the csv
    save_csv
  end

  private

  def build_instance(attributes)
    attributes[:id] = attributes[:id].to_i
    attributes[:delivered] = attributes[:delivered] == 'true'
    meal_id = attributes[:meal_id].to_i
    meal = @meal_repository.find(meal_id)
    attributes[:meal] = meal

    customer_id = attributes[:customer_id].to_i
    customer = @customer_repository.find(customer_id)
    attributes[:customer] = customer

    employee_id = attributes[:employee_id].to_i
    employee = @employee_repository.find(employee_id)
    attributes[:employee] = employee

    Order.new(attributes)
  end
end
