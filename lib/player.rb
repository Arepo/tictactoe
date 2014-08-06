require_relative 'board'

class Player

	attr_reader :chosen_mark
	attr_reader :board

	def initialize(chosen_mark = :X)
		@chosen_mark = chosen_mark
		@board = Board.instance
	end

	def play_on(square)
		square.mark = chosen_mark
	end

	# def row(num)
	# 	board.row(num)
	# end

end