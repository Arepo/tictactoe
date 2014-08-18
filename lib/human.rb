module Human

	def get_row
		puts "Which row would you like to play on (1, 2 or 3)?"
		chosen_row = gets.chomp.to_i
	end

	def get_square
		puts "And which square (1, 2 or 3)?"
		chosen_square = gets.chomp.to_i
	end

	def your_turn
		play_on(square_at(get_row, get_square))
	end

end