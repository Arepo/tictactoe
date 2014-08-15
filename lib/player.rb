require_relative 'board'
require_relative 'human'

class Player

	attr_reader :chosen_mark
	attr_reader :board

	def initialize(chosen_mark = :X, human = true)
		@chosen_mark = chosen_mark
		@board = Board.instance
		if human
			extend Human
		end
		# human? ? include Human : include Joshua
	end

	def play_on(square)
		square.mark = chosen_mark
	end

	# def row(num)
	# 	board.row(num)
	# end

end