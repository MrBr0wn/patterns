# frozen_string_literal: true

class ChocolateBoiler
  @instance = new
  @@boiled = false
  @@empty = true

  private_class_method :new

  def self.instance
    @instance
  end

  def fill
    if empty?
      @@empty = false
      @@boiled = false
      'Boiler has been filled, but not boiled.'
    else
      'Boiler already filled.'
    end
  end

  def drain
    if !empty? && boiled?
      @@empty = true
      'Boiler has been draining.'
    else
      'Boiler already draining.'
    end
  end

  def boil
    if !empty? && !boiled?
      @@boiled = true
      'Boiler has been boiled.'
    else
      'Boiler already boiled.'
    end
  end

  private

  def empty?
    defined?(@@empty) && @@empty
  end

  def boiled?
    defined?(@@boiled) && @@boiled
  end
end

chocolate_boiler1 = ChocolateBoiler.instance
chocolate_boiler2 = ChocolateBoiler.instance

puts "Fill chocolate_boiler1: #{chocolate_boiler1.fill}"
puts "Fill chocolate_boiler2: #{chocolate_boiler2.fill}\n\n"

puts "Fill chocolate_boiler2: #{chocolate_boiler1.boil}"
puts "Fill chocolate_boiler1: #{chocolate_boiler2.boil}\n\n"

puts "Fill chocolate_boiler1: #{chocolate_boiler1.drain}"
puts "Fill chocolate_boiler2: #{chocolate_boiler2.drain}\n\n"

puts "chocolate_boiler1 ID: #{chocolate_boiler1.object_id}"
puts "chocolate_boiler2 ID: #{chocolate_boiler2.object_id}"
