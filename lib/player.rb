require_relative 'board'
require_relative 'mark'

class Player

	attr_reader :mark
	attr_reader :board

	def initialize
		@mark = Mark.new(self)
		@board = Board.instance
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