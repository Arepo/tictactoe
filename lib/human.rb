module Human

	def get_row
		puts "Which row would you like to play on (1, 2 or 3)?"
		chosen_row = gets.chomp
	end

	def get_square
		puts "And which square (1, 2 or 3)?"
		chosen_square = gets.chomp
	end

end