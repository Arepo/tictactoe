require_relative 'row'

class Game

	def initialize
		@grid = []
		make_rows
	end

	def row(row_num)
		@grid[row_num - 1]
	end

	def add_blank_row
		Row.new(3) { Square.new }
	end

	def make_rows
		3.times {@grid << add_blank_row}
	end

	def print_rows

	end

end

