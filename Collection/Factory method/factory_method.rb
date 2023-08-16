class Creator
	def factory_method
		raise NotEmplimentedError, "#{self.class} has not implemented method '#{__method__}'" 
	end

	def some_operation
		product = factory_method

		result = "Creator: The same creator's code has just worked with #{product.operation}"

		result
	end
end

class ConcreteCreatorA < Creator
	def factory_method
		ConcreteProductA.new
	end
end

class ConcreteCreatorB < Creator
	def factory_method
		ConcreteProductB.new
	end
end

class Product
	def operation
		raise NotEmplimentedError, "#{self.class} has not implemented method '#{__method__}'"
	end
end

class ConcreteProductA < Product
	def operation
		'{Result of the ConcreteProductA}'
	end
end

class ConcreteProductB < Product
	def operation
		'{Result of the ConcreteProductB}'
	end
end

def client_code(creator)
	puts "Client: I'm not aware of the creator's class, but it still works.\n #{creator.some_operation}"
end

puts 'App Launched with the ConcreteCreatorA.'
client_code(ConcreteCreatorA.new)
puts "\n\n"

puts 'App Launched with the ConcreteCreatorB.'
client_code(ConcreteCreatorB.new)