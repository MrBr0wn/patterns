# frozen_string_literal: true

class Component
  def parent
    @parent
  end

  def parent=(parent)
    @parent = parent
  end

  def add(component)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'" 
  end

  def remove(component)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def composite?
    false
  end

  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class Leaf < Component
  def operation
    'Leaf'
  end
end

class Composite < Component
  def initialize
    @children = []
  end

  def add(component)
    @children.append(component)
    component.parent = self
  end

  def remove(component)
    @children.remove(component)
    component.parent = nil
  end

  def composite?
    true
  end

  def operation
    results = []
    @children.each do |child|
      results.append(child.operation)
    end
    "Branch(#{results.join('+')})"
  end
end

def client_code(component)
  puts "RESULT: #{component.operation}"
end

def client_code2(component1, component2)
  component1.add(component2) if component1.composite?

  print "RESULT: #{component1.operation}"
end

simple = Leaf.new
puts 'Client: I\'ve got a simple component:'
client_code(simple)
puts "\n"

tree = Composite.new

branch1 = Composite.new
branch1.add(Leaf.new)
branch1.add(Leaf.new)

branch2 = Composite.new
branch2.add(Leaf.new)

tree.add(branch1)
tree.add(branch2)

puts 'Client: Now I\'ve got a composite tree:'
client_code(tree)
puts "\n"
client_code2(tree, simple)
