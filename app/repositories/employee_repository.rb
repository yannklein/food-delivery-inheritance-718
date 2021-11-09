require 'csv'
require_relative '../models/employee'
require_relative 'base_repository'

class EmployeeRepository < BaseRepository
  def all_riders
    @elements.select { |employee| employee.rider? }
  end

  def find_by_username(username)
    @elements.find do |employee|
      username == employee.username
    end
  end

  def find(id)
    @elements.find { |employee| employee.id == id } # instance or nil
  end

  private

  def build_instance(attributes)
    attributes[:id] = attributes[:id].to_i
    Employee.new(attributes)
  end
end
