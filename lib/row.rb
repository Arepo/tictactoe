require_relative 'square'

class Array

	def square(num) 
		self[num - 1]
	end

	def to_s
		self.map {|square| square.to_s }.join
	end

	def marked_by?(source)
		self.any? {|square| square.source == source if square.mark }
	end

end