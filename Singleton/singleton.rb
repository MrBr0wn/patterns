# frozen_string_literal: true

class Singleton
  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def some_business_logic
    # ...
  end
end

s1 = Singleton.instance
s2 = Singleton.instance

if s1.equal?(s2)
  puts 'Singleton works, both variables contain the same instance.'
else
  puts 'Singleton failed, variables contain different instances.'
end

puts "s1 ID: #{s1.object_id} and s2 ID: #{s2.object_id}"
