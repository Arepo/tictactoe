module WinChecker

	attr_reader :board

	def initialize
		super
		@board = Board.instance
	end

	def completed_row?
		board.rows.any? { |row| equivalent_squares_in?(row) }
		# return true if row.all? {|square| square == :O }
	end

	def completed_column?
		board.columns.any? { |column| equivalent_squares_in?(column) }
	end

	def completed_diagonal?
		board.diagonals.any? { |diagonal| equivalent_squares_in?(diagonal) }
	end

	def equivalent_squares_in?(squares)
		return true if squares.inject do |last_square, this_square| 
			last_square == this_square ? this_square : false 
		end
	end

end