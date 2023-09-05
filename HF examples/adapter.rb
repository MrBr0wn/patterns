# frozen_string_literal: true

class Duck
  def quack
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def fly
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class MallardDuck < Duck
  def quack
    puts 'Quack'
  end

  def fly
    puts 'I\'m flying'
  end
end

class Turkey
  def gobble
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def fly
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class WildTurkey < Turkey
  def gobble
    puts 'Gobble gobble'
  end

  def fly
    puts 'I\'m flying a short distance'
  end
end

class TurkeyAdapter < Duck
  def initialize(turkey)
    @turkey = turkey
  end

  def quack
    @turkey.gobble
  end

  def fly
    5.times do
      @turkey.fly
    end
  end
end

class DuckTestDrive
  def initialize
    duck = MallardDuck.new
    turkey = WildTurkey.new
    turkey_adapter = TurkeyAdapter.new(turkey)

    puts 'The Turkey says...'
    turkey.gobble
    turkey.fly

    puts 'The Duck says...'
    test_duck(duck)

    puts 'The TurkeyAdapter says...'
    test_duck(turkey_adapter)
  end

  def test_duck(duck)
    duck.quack
    duck.fly
  end
end

DuckTestDrive.new
