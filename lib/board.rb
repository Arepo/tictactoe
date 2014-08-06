require_relative 'row'
require 'singleton'

class Board

	include Singleton

	attr_reader :rows

	def initialize
		@rows = []
		make_rows
	end

	def row(row_num)
		rows[row_num - 1]
	end

	def add_blank_row
		Array.new(3) { Square.new }
	end

	def make_rows
		3.times {rows << add_blank_row}
	end

	def display
		rows.each {|row| puts row.to_s}
	end

	def column(column_num)
		columns[column_num - 1]
		# (1..3).map {|row_num| row(row_num).square(column_num)}
	end

	def columns
		rows.transpose
	end

	def diagonals
		diagonal_lines = []
		# [rows, columns].each do |lines|
			# rows.each_with_index {|line, square_num| diagonal_lines << line[square_num] }
			# columns.each_with_index {|line, square_num| diagonal_lines << line[square_num] }
		# end
		# diagonal = (1..3).map {|num| board.row(num).square(num) }
		# equivalent_squares_in?(diagonal)
		# diagonal_lines
		# .partition {|square| diagonal_lines.find_index(square) < 3 }
		reverse_num = 4
		1.upto(3) do |num|
			diagonal_lines << row(num).square(num)
			diagonal_lines << row(num).square(reverse_num -= 1)
		end

		# 3.downto(1) {|num| diagonal_lines << row(num1).square(num2) }
		
		diagonal_lines.partition {|square| diagonal_lines.find_index(square) % 2 == 0 }
	end

end

p Board.instance.diagonals