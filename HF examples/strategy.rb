# frozen_string_literal: true

class Duck
  def initialize
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def fly_behavior
    @fly_behavior
  end

  def quack_behavior
    @quack_behavior
  end

  def fly_behavior=(fly_behavior)
    @fly_behavior = fly_behavior
  end

  def quack_behavior=(quack_behavior)
    @quack_behavior = quack_behavior
  end

  def perform_quack
    quack_behavior.quack
  end

  def perform_fly
    fly_behavior.fly
  end

  def swim
    puts 'All ducks float, even decoys!'
  end

  def display_duck
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class FlyBehavior
  def fly
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class FlyWithWings < FlyBehavior
  def fly
    puts 'I\'m flying!!'
  end
end

class FlyNoWay < FlyBehavior
  def fly
    puts 'I can\'t fly'
  end
end

class FlyRocketPowered < FlyBehavior
  def fly
    puts 'I\'m flying with a rocket'
  end
end

class QuackBehavior
  def quack
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class Quack < QuackBehavior
  def quack
    puts 'Quack-quack, motherfucka'
  end
end

class Squeak < QuackBehavior
  def quack
    puts 'Squeak'
  end
end

class MuteQuack < QuackBehavior
  def quack
    puts '<< Silence >>'
  end
end

class MallardDuck < Duck
  def initialize
    @fly_behavior = FlyWithWings.new
    @quack_behavior = Quack.new
  end

  def display_duck
    puts 'I\'m a real Mallard duck'
  end
end

class ModelDuck < Duck
  def initialize
    @fly_behavior = FlyNoWay.new
    @quack_behavior = Quack.new
  end

  def display_duck
    puts 'I\'m a model duck'
  end
end

class MiniDuckSimulator
  def initialize
    mallard = MallardDuck.new
    mallard.perform_quack
    mallard.perform_fly

    model_duck = ModelDuck.new
    model_duck.perform_fly
    model_duck.fly_behavior = FlyRocketPowered.new
    model_duck.perform_fly
  end
end

MiniDuckSimulator.new
