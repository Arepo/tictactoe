require_relative 'row'

class Board

	attr_reader :row1, :row2, :row3

	def initialize
		make_row_1
		make_row_2
		make_row_3
	end

	def row(row_num)
		self.send("row#{row_num}")
	end

	def make_generic_row
		Row.new(3) { Square.new }
	end

	def make_row_1
		@row1 = make_generic_row
	end

	def make_row_2
		@row2 = make_generic_row
	end

	def make_row_3
		@row3 = make_generic_row
	end

	# def method_missing(method, *args)
	# 	if method.to_s == make_row
	# end

end

