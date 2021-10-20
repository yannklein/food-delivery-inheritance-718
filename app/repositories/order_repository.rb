require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = [] # elements
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @orders
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select { |order| order.employee == employee }
  end

  def mark_as_delivered(order)
    # change the status of the order
    order.deliver!
    # save the csv ⚠️
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file_path, csv_options) do |attributes|
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

      @orders << Order.new(attributes)
      @next_id += 1
    end
  end
end
