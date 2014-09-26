require_relative 'board'
require_relative 'mark'

class Player

	attr_reader :mark
	attr_reader :board

	def initialize(player_type = {human: true})
		@mark = Mark.new(self)
		@board = Board.instance
		@player_type = player_type
	end

	def play_on(square)
		square.mark_with(mark)
	end

	def square_at(row_num, square_num)
		board.row(row_num).square(square_num)
	end

	def your_turn
		raise NotImplementedError, "This #{self.class} cannot respond to"
	end

end