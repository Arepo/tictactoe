require_relative 'row'
require 'singleton'

class Board

	include Singleton

	include Singleton

	attr_reader :columns

	def initialize
		@columns = []
		make_rows
		# @player1 = Player.new
		# @player2 = Player.new(:O)
	end

	def row(row_num)
		columns[row_num - 1]
	end

	def add_blank_row
		Row.new(3) { Square.new }
	end

	def make_rows
		3.times {columns << add_blank_row}
	end

	def display
		columns.each {|row| puts row.to_s}
	end	

end
