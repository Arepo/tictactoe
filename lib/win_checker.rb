module WinChecker

	attr_reader :board

	def initialize
		@board = Board.instance
	end

	def completed_row?
		board.rows.any? { |row| equivalent_squares_in?(row) }
	end

	def completed_column?
		board.columns.any? { |column| equivalent_squares_in?(column) }
	end

	def completed_diagonal?
		board.diagonals.any? { |diagonal| equivalent_squares_in?(diagonal) }
	end

	def completed_line?
		[completed_row?, completed_column?, completed_diagonal?].any? {|candidate| candidate }
	end

	def board_full?
		board.rows.all? { |row| row.all? {|square| square.mark } }
	end

	def equivalent_squares_in?(squares)
		# squares.map(&:owner).uniq.length == 1
		return true if squares.inject do |last_square, this_square| 
			last_square == this_square ? this_square : false 
		end
	end

end