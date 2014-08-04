class Player

	attr_reader :chosen_mark
	attr_reader :game

	def initialize(chosen_mark = :X)
		@chosen_mark = chosen_mark
		@game = Game.new
	end

	def play_on(square)
		square.mark = chosen_mark
	end

end