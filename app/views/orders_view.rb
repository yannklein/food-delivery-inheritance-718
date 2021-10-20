class OrdersView < BaseView
  def display(orders)
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1} - #{order.meal.name} - Rider: #{order.employee.username}\n#{order.customer.name} #{order.customer.address}"
      end
    else
      puts "No orders yet 😢"
    end
  end
end
