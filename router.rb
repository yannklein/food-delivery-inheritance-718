class Router
  def initialize(meals_controller)
    @meals_controller = meals_controller
    @running = true
  end

  def run
    while @running
      choice = display_menu
      print `clear`
      action(choice)
    end
  end

  private

  def display_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2 - Create a meal"
    # puts "3 - List all customers"
    # puts "4 - Create a customer"
    puts "0 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    # when 3 then @meals_controller.list
    # when 4 then @meals_controller.list
    when 0 then @running = false
    else
      puts "Try again..."
    end
  end
end
