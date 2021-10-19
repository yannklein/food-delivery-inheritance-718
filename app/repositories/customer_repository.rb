require 'csv'
require_relative '../models/customer'
require_relative 'base_repository'

class CustomerRepository < BaseRepository

  private

  def build_instance(attributes)
    attributes[:id] = attributes[:id].to_i
    Customer.new(attributes)
  end
end
