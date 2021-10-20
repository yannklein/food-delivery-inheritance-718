require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def log_in
    # ask user for username
    username = @sessions_view.ask_for('username')
    # ask user for password
    password = @sessions_view.ask_for('password')
    # employee = ask the employee_repo for an employee with the username
    employee = @employee_repository.find_by_username(username)
    # compare the user given password with the password from the repo
    if employee && password == employee.password
      # welcome the employee
      @sessions_view.welcome(employee)
      return employee
    else
      # tell them it's invalid
      @sessions_view.invalid
      log_in
    end
  end
end
