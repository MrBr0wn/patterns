# frozen_string_literal: true

class CoffeineBeverage
  def prepare_recipe
    puts "#{self.class} preparing:\n\n"
    boil_water
    brew
    pour_in_cup
    add_condiments
  end

  def brew
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def add_condiments
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def pour_in_cup
    puts 'Pouring into cup'
  end

  def boil_water
    puts 'Boiling water'
  end
end

class Coffee < CoffeineBeverage
  def initialize; end

  def brew
    puts 'Dripping Coffee though'
  end

  def add_condiments
    puts 'Adding Sugar and Milk'
  end
end

class Tea < CoffeineBeverage
  def initialize; end

  def brew
    puts 'Steeping the tea'
  end

  def add_condiments
    puts 'Adding Lemon'
  end
end

tea = Tea.new
tea.prepare_recipe

puts "\n#{'-' * 25}\n\n"

coffee = Coffee.new
coffee.prepare_recipe

puts "\n#{'-' * 25}\n\n"


# implement hook

class CoffeineBeverageWithHook
  def prepare_recipe
    puts "#{self.class} preparing:\n\n"
    boil_water
    brew
    pour_in_cup
    if customer_wants_condiments
      add_condiments
    end
  end

  def brew
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def add_condiments
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def pour_in_cup
    puts 'Pouring into cup'
  end

  def boil_water
    puts 'Boiling water'
  end

  def customer_wants_condiments
    true
  end
end

class CoffeeWithHook < CoffeineBeverageWithHook
  def initialize; end

  def brew
    puts 'Dripping Coffee through filter'
  end

  def add_condiments
    puts 'Adding Sugar and Milk'
  end

  def customer_wants_condiments
    answer = %w[yes no]

    answer.sample == 'yes'
  end
end

coffee_with_hook = CoffeeWithHook.new
coffee_with_hook.prepare_recipe
