class BaseView
  def ask_for(thing)
    puts "What's the #{thing}?"
    print '> '
    gets.chomp # string
  end
end
