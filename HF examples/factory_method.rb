# frozen_string_literal: true

class PizzaStore
  def initialize
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def order_pizza(type)
    pizza = create_pizza(type)

    puts "--- Making a #{pizza.name} ---"
    pizza.prepare
    pizza.bake
    pizza.cut
    pizza.box
    pizza
  end

  def create_pizza(type)
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class NYPizzaStore < PizzaStore
  def initialize
    @toppings = []
  end

  def create_pizza(type)
    if type == "cheese"
      pizza = NYStyleCheesePizza.new
    elsif type == "pepperoni"
      pizza = NYStylePepperoniPizza.new
    elsif type == "clam"
      pizza = NYStyleClamPizza.new
    elsif type == "veggie"
      pizza = NYStyleVeggiePizza.new
    end
  end
end

class ChicagoPizzaStore < PizzaStore
  def initialize
    @toppings = []
  end
  
  def create_pizza(type)
    if type == "cheese"
      pizza = ChicagoStyleCheesePizza.new
    elsif type == "pepperoni"
      pizza = ChicagoStylePepperoniPizza.new
    elsif type == "clam"
      pizza = ChicagoStyleClamPizza.new
    elsif type == "veggie"
      pizza = ChicagoStyleVeggiePizza.new
    end
  end
end

class Pizza
  attr_accessor :name
  attr_reader :toppings

  def initialize
    @toppings = []
  end

  def prepare
    puts "Preparing #{@name}"
    puts "Tossing dough..."
    puts "Adding sauce..."
    puts "Adding toppings:"
    @toppings.each do |item|
      puts item
    end
  end

  def bake
    puts "Bake for 25 minutes at 350"
  end

  def cut
    puts "Cutting the pizza into diagonal slices"
  end

  def box
    puts "Place pizza in official PizzaStore box"
  end

  def display
    puts "---- #{@name} ----\n"
    puts "#{@dough} \n"
    puts "#{@sauce} \n"
    @toppings.each do |item|
      puts "#{item} \n"
    end
  end
end

class NYStyleCheesePizza < Pizza
  def initialize
    super
    @name = 'NY Style Sauce and Cheese Pizza'
    @dough = 'Thin Crust Dough'
    @sauce = 'Marinara Sauce'

    @toppings << 'Grated Reggiano Cheese'
  end
end

class NYStyleClamPizza < Pizza
  def initialize
    super
    @name = 'NY Style Clam Pizza'
    @dough = 'Thin Crust Dough'
    @sauce = 'Marinara Sauce'

    @toppings << 'Grated Reggiano Cheese'
    @toppings << 'Fresh Clams from Long Island Sound'
  end
end

class NYStylePepperoniPizza < Pizza
  def initialize
    super
    @name = 'NY Style Pepperoni Pizza'
    @dough = 'Thin Crust Dough'
    @sauce = 'Marinara Sauce'

    @toppings << 'Grated Reggiano Cheese'
    @toppings << 'Sliced Pepperoni'
    @toppings << 'Garlic'
    @toppings << 'Onion'
    @toppings << 'Mushrooms'
    @toppings << 'Red Pepper'
  end
end

class NYStyleVeggiePizza < Pizza
  def initialize
    super
    @name = 'NY Style Veggie Pizza'
    @dough = 'Thin Crust Dough'
    @sauce = 'Marinara Sauce'

    @toppings << 'Grated Reggiano Cheese'
    @toppings << 'Garlic'
    @toppings << 'Onion'
    @toppings << 'Mushrooms'
    @toppings << 'Red Pepper'
  end
end

class ChicagoStyleCheesePizza < Pizza
  def initialize
    super
    @name = 'Chicago Style Deep Dish Cheese Pizza'
    @dough = 'Extra Thick Crust Dough'
    @sauce = 'Plum Tomato Sauce'

    @toppings << 'Shredded Mozzarella Cheese'
  end

  def cut
    puts 'Cutting the pizza into square slices'
  end
end

class ChicagoStyleClamPizza < Pizza
  def initialize
    super
    @name = 'Chicago Style Clam Pizza'
    @dough = 'Extra Thick Crust Dough'
    @sauce = 'Plum Tomato Sauce'

    @toppings << 'Shredded Mozzarella Cheese'
    @toppings << 'Frozen Clams from Chesapeake Bay'
  end

  def cut
    puts 'Cutting the pizza into square slices'
  end
end

class ChicagoStylePepperoniPizza < Pizza
  def initialize
    super
    @name = 'Chicago Style Pepperoni Pizza'
    @dough = 'Extra Thick Crust Dough'
    @sauce = 'Plum Tomato Sauce'

    @toppings << 'Shredded Mozzarella Cheese'
    @toppings << 'Black Olives'
    @toppings << 'Spinach'
    @toppings << 'Eggplant'
    @toppings << 'Sliced Pepperoni'
  end

  def cut
    puts 'Cutting the pizza into square slices'
  end
end

class ChicagoStyleVeggiePizza < Pizza
  def initialize
    super
    @name = 'Chicago Deep Dish Veggie Pizza'
    @dough = 'Extra Thick Crust Dough'
    @sauce = 'Plum Tomato Sauce'

    @toppings << 'Shredded Mozzarella Cheese'
    @toppings << 'Black Olives'
    @toppings << 'Spinach'
    @toppings << 'Eggplant'
  end

  def cut
    puts 'Cutting the pizza into square slices'
  end
end

class PizzaTestDrive
  def initialize
    ny_store = NYPizzaStore.new
    chicago_store = ChicagoPizzaStore.new

    pizza = ny_store.order_pizza('cheese')
    puts "Ethan ordered a #{pizza.name}\n\n"

    pizza = chicago_store.order_pizza('cheese')
    puts "Joel ordered a #{pizza.name}\n\n"

    pizza = ny_store.order_pizza('clam')
    puts "Ethan ordered a #{pizza.name}\n\n"

    pizza = chicago_store.order_pizza('clam')
    puts "Joel ordered a #{pizza.name}\n\n"

    pizza = ny_store.order_pizza('pepperoni')
    puts "Ethan ordered a #{pizza.name}\n\n"

    pizza = chicago_store.order_pizza('pepperoni')
    puts "Joel ordered a #{pizza.name}\n\n"

    pizza = ny_store.order_pizza('veggie')
    puts "Ethan ordered a #{pizza.name}\n\n"

    pizza = chicago_store.order_pizza('veggie')
    puts "Joel ordered a #{pizza.name}\n\n"
  end
end

PizzaTestDrive.new
