require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # get all of the customers from the customer repo
    customers = @customer_repository.all
    # give those customers to the view
    @customers_view.display(customers)
  end

  def add
    # ask user for name
    name = @customers_view.ask_for('name')
    # ask user for address
    address = @customers_view.ask_for('address')
    # create an instance of a customer
    customer = Customer.new(name: name, address: address)
    # give the customer to the repository
    @customer_repository.create(customer)
  end
end
