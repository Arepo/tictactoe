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
		# player_type[:human] ? extend Human : extend Joshua # ternary operator doesn't work here?
	end

	def play_on(square)
		square.mark = chosen_mark
	end

	def square_at(row_num, square_num)
		board.row(row_num).square(square_num)
	end

	# def row(num)
	# 	board.row(num)
	# end

end