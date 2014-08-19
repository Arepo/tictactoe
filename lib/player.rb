require_relative 'board'
require_relative 'joshua'
require_relative 'human'
require_relative 'mark'

class Player

	attr_reader :mark
	attr_reader :board

	def initialize(player_type = {human: true})
		@mark = Mark.new(self)
		@board = Board.instance
		@player_type = player_type
		if player_type[:human]
			extend Human
		else
			extend Joshua
		end
	end

	def play_on(square)
		square.mark = mark
	end

	def square_at(row_num, square_num)
		board.row(row_num).square(square_num)
	end

	# def row(num)
	# 	board.row(num)
	# end

end