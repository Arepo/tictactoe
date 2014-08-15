require_relative 'board'
require_relative 'joshua'
require_relative 'human'

class Player

	attr_reader :chosen_mark
	attr_reader :board

	def initialize(chosen_mark = :X, player_type = {human: true})
		@chosen_mark = chosen_mark
		@board = Board.instance
		@player_type = player_type
		if player_type[:human]
			extend Human
		else
			extend Joshua
		end
		# human ? extend Human : extend Joshua
	end

	def play_on(square)
		square.mark = chosen_mark
	end

	# def row(num)
	# 	board.row(num)
	# end

end