require 'board'
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

end