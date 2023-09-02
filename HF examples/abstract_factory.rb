# frozen_string_literal: true

class Topping
  def initialize
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class ThinCrustDough < Topping
  def initialize
    puts 'Thin Crust Dough'
  end
end

class MarinarSauce < Topping
  def initialize
    puts 'Marinara Sauce'
  end
end

class ReggianoCheese < Topping
  def initialize
    puts 'Reggiano Cheese'
  end
end

class Garlic < Topping
  def initialize
    puts 'Garlic'
  end
end

class Onion < Topping
  def initialize
    puts 'Onion'
  end
end

class Mushroom < Topping
  def initialize
    puts 'Mushrooms'
  end
end

class RedPepper < Topping
  def initialize
    puts 'Red Pepper'
  end
end

class SlicedPepperoni < Topping
  def initialize
    puts 'Sliced Pepperoni'
  end
end

class FreshClams < Topping
  def initialize
    puts 'Fresh Clams from Long Island Sound'
  end
end

class FrozenClams < Topping
  def initialize
    puts 'Frozen Clams from Chesapeake Bay'
  end
end

class PlumTomatoSauce < Topping
  def initialize
    puts 'Tomato sauce with plum tomatoes'
  end
end

class MozzarellaCheese < Topping
  def initialize
    puts 'Shredded Mozzarella'
  end
end

class BlackOlives < Topping
  def initialize
    puts 'Black Olives'
  end
end

class Spinach < Topping
  def initialize
    puts 'Spinach'
  end
end

class Eggplant < Topping
  def initialize
    puts 'Eggplant'
  end
end

class PizzaStore

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
  def create_pizza(item)
    ingredient_factory = NYPizzaIngredientFactory.new

    if item == 'cheese'
      pizza = CheesePizza.new(ingredient_factory)
      pizza.name = 'New York Style Cheese Pizza'
    elsif item == 'veggie'
      pizza = VeggiePizza.new(ingredient_factory)
      pizza.name = 'New York Style Veggie Pizza'
    elsif item == 'clam'
      pizza = ClamPizza.new(ingredient_factory)
      pizza.name = 'New York Style Clam Pizza'
    elsif item == 'pepperoni'
      pizza = PepperoniPizza.new(ingredient_factory)
      pizza.name = 'New York Style Pepperoni Pizza'
    end
    pizza
  end
end

class ChicagoPizzaStore < PizzaStore
  def create_pizza(item)
    ingredient_factory = ChicagoPizzaIngredientFactory.new

    if item == 'cheese'
      pizza = CheesePizza.new(ingredient_factory)
      pizza.name = 'Chicago Style Cheese Pizza'
    elsif item == 'veggie'
      pizza = VeggiePizza.new(ingredient_factory)
      pizza.name = 'Chicago Style Veggie Pizza'
    elsif item == 'clam'
      pizza = ClamPizza.new(ingredient_factory)
      pizza.name = 'Chicago Style Clam Pizza'
    elsif item == 'pepperoni'
      pizza = PepperoniPizza.new(ingredient_factory)
      pizza.name = 'Chicago Style Pepperoni Pizza'
    end
    pizza
  end
end

class PizzaIngredientFactory
  def create_dough
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def create_sauce
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def create_cheese
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def create_veggies
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def create_pepperoni
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def create_clam
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class NYPizzaIngredientFactory < PizzaIngredientFactory
  def create_dough
    ThinCrustDough.new
  end

  def create_sauce
    MarinarSauce.new
  end

  def create_cheese
    ReggianoCheese.new
  end

  def create_veggies
    [Garlic.new, Onion.new, Mushroom.new, RedPepper.new]
  end

  def create_pepperoni
    SlicedPepperoni.new
  end

  def create_clam
    FreshClams.new
  end
end

class ChicagoPizzaIngredientFactory < PizzaIngredientFactory
  def create_dough
    ThinCrustDough.new
  end

  def create_sauce
    PlumTomatoSauce.new
  end

  def create_cheese
    MozzarellaCheese.new
  end

  def create_veggies
    [BlackOlives.new, Spinach.new, Eggplant.new]
  end

  def create_pepperoni
    SlicedPepperoni.new
  end

  def create_clam
    FrozenClams.new
  end
end

class Pizza
  attr_accessor :name
  attr_reader :ingredients

  def initialize(ingredient_factory)
    @ingredient_factory = ingredient_factory
    @dough = nil
    @sauce = nil
    @cheese = nil
    @veggies = nil
    @pepperoni = nil
    @clam = nil
  end

  def prepare
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
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
end

class CheesePizza < Pizza
  def prepare
    puts "Preparing #{@name}"
    @dough = @ingredient_factory.create_dough
    @sauce = @ingredient_factory.create_sauce
    @cheese = @ingredient_factory.create_cheese
  end
end

class ClamPizza < Pizza
  def prepare
    puts "Preparing #{@name}"
    @dough = @ingredient_factory.create_dough
    @sauce = @ingredient_factory.create_sauce
    @cheese = @ingredient_factory.create_cheese
    @clam = @ingredient_factory.create_clam
  end
end

class PepperoniPizza < Pizza
  def prepare
    puts "Preparing #{@name}"
    @dough = @ingredient_factory.create_dough
    @sauce = @ingredient_factory.create_sauce
    @cheese = @ingredient_factory.create_cheese
    @veggies = @ingredient_factory.create_veggies
  end
end

class VeggiePizza < Pizza
  def prepare
    puts "Preparing #{@name}"
    @dough = @ingredient_factory.create_dough
    @sauce = @ingredient_factory.create_sauce
    @cheese = @ingredient_factory.create_cheese
    @veggies = @ingredient_factory.create_veggies
  end
end

# client code
class PizzaTestDrive
  def initialize
    ny_pizza_store = NYPizzaStore.new
    chicago_pizza_store = ChicagoPizzaStore.new

    pizza = ny_pizza_store.order_pizza('cheese')
    puts "Ethan ordered a #{pizza.name}\n\n"

    pizza = chicago_pizza_store.order_pizza('cheese')
    puts "Joel ordered a #{pizza.name}\n\n"

    pizza = ny_pizza_store.order_pizza('clam')
    puts "Ethan ordered a #{pizza.name}\n\n"

    pizza = chicago_pizza_store.order_pizza('clam')
    puts "Joel ordered a #{pizza.name}\n\n"

    pizza = ny_pizza_store.order_pizza('pepperoni')
    puts "Ethan ordered a #{pizza.name}\n\n"

    pizza = chicago_pizza_store.order_pizza('pepperoni')
    puts "Joel ordered a #{pizza.name}\n\n"

    pizza = ny_pizza_store.order_pizza('veggie')
    puts "Ethan ordered a #{pizza.name}\n\n"

    pizza = chicago_pizza_store.order_pizza('veggie')
    puts "Joel ordered a #{pizza.name}\n\n"
  end
end

PizzaTestDrive.new