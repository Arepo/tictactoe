module Human

	def get_row
		puts "Which row would you like to play on (1, 2 or 3)?"
		chosen_row = gets.chomp
		confirm_match_of(chosen_row, "row")
	end

	def get_square
		puts "And which square (1, 2 or 3)?"
		chosen_square = gets.chomp
		confirm_match_of(chosen_square, "square")
	end

	def your_turn
		unless play_on(square_at(get_row, get_square))
			puts "Please make sure you choose an empty space."
			your_turn
		end
	end

	private

	def confirm_match_of(input, area)
		if %w{1 2 3}.include?(input)
			input.to_i
		else
			puts "Please enter a number from 1 to 3."
			eval("get_#{area}")
		end
	end

end