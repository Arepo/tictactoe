module Joshua

	attr_reader :board

	def initialize
		@board = Board.instance
	end

	# def check_rows
	# 	board.rows.each {|square| }
	# 	add_candidate(board.row(1).square(1))
	# end

	def priority_1?(*squares)
		true if squares[0] == squares[1] || squares[0] == squares[2] || squares[1] == squares[2] 
	end

	def pick_candidate(*squares)
		squares.select
	end

	def determine_square
		[1,2]
	end

end