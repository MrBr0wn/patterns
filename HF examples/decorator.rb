# frozen_string_literal: true

class Beverage
  def cost
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def description
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class CondimentDecorator
  attr_accessor :component

  def initialize(component)
    @component = component
  end

  def description
    @component.description
  end

  def cost
    @component.cost
  end
end

class Espresso < Beverage
  def initialize
    @description = 'Espresso'
  end

  def cost
    1.99
  end

  def description
    "#{self.class.superclass.name}, #{@description}"
  end
end

class HouseBlend < Beverage
  def initialize
    @description = 'House Blend Coffee'
  end

  def cost
    0.89
  end

  def description
    "#{self.class.superclass.name}, #{@description}"
  end
end

class Mocha < CondimentDecorator
  def initialize(beverage)
    @beverage = beverage
  end

  def description
    "#{@beverage.description}, Mocha"
  end

  def cost
    @beverage.cost + 0.20
  end
end

class StarbuzzCoffee
  beverage = Espresso.new
  puts "#{beverage.description} #{beverage.cost}"

  beverage2 = HouseBlend.new
  beverage2 = Mocha.new(beverage2)
  beverage2 = Mocha.new(beverage2)
  puts "#{beverage2.description} #{beverage2.cost}"
end
