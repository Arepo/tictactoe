class Player

	attr_reader :chosen_mark

	def initialize(chosen_mark = :X)
		@chosen_mark = chosen_mark
	end

	def play_on(square)
		square.mark = chosen_mark
	end

end