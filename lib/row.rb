require_relative 'square'

class Row < Array

	def square(num) 
		self[num - 1]
	end

	def first_square
		self[0]
	end

	def second_square
		self[1]
	end

	def third_square
		self[2]
	end

end