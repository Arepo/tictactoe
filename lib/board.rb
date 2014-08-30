require_relative 'row'
require 'singleton'

class Board

	EdgeLength = 3

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
		Array.new(EdgeLength) { Square.new }
	end

	def make_rows
		EdgeLength.times {rows << add_blank_row}
	end

	def display
		rows.each {|row| puts row.to_s}
	end

	def column(column_num)
		columns[column_num - 1]
	end

	def columns
		rows.transpose
	end

	def diagonals
		diagonal_lines = [[],[]]
		counter = 4
		1.upto(EdgeLength) do |num|
			diagonal_lines[0] << row(num).square(num)
			diagonal_lines[1] << row(num).square(counter -= 1)
		end
		diagonal_lines
	end

end
