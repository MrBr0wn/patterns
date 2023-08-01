class Context
	attr_writer :strategy

	def initialize(strategy)
		@strategy = strategy
	end

	def strategy=(strategy)
		@strategy = strategy
	end

	def do_some_buisness_logic
		# ...

		puts 'Context: Sorting data using the strategy (not sure how it will do it)'
		result = @strategy.do_algorithm(%w[a b c d e])
		puts result.join(',')
		
		# ...
	end
end

class Strategy
	def do_algorithm(_data)
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end
end

class ConcreteStrategyA < Strategy
	def do_algorithm(data)
		data.sort
	end
end

class ConcreteStrategyB < Strategy
	def do_algorithm(data)
		data.sort.reverse
	end
end

context = Context.new(ConcreteStrategyA.new)
puts 'Client: Strategy is set to normal sorting.'
context.do_some_buisness_logic
puts "\n\n"

puts 'Client: Strategy is set to reverse sorting.'
context.strategy = ConcreteStrategyB.new
context.do_some_buisness_logic