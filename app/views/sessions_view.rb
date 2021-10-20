require_relative 'base_view'

class SessionsView < BaseView
  def welcome(employee)
    puts "Welcome #{employee.username}!"
  end

  def invalid
    puts "Wrong username or password..."
  end
end
