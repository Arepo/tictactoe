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
		Row.new(3) { Square.new }
	end

	def make_rows
		3.times {rows << add_blank_row}
	end

	def display
		rows.each {|row| puts row.to_s}
	end	

end
