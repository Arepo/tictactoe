require_relative 'square'

class Array

	def square(num) 
		self[num - 1]
	end

	def to_s
		self.map {|square| square.to_s }.join
	end

end