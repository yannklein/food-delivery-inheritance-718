require 'csv'
require_relative '../models/customer'
require_relative 'base_repository'

class CustomerRepository < BaseRepository

  def find(id)
    @elements.find { |customer| customer.id == id } # instance or nil
  end

  private

  def build_instance(attributes)
    attributes[:id] = attributes[:id].to_i
    Customer.new(attributes)
  end
end
