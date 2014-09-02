module Joshua

	attr_reader :board
	attr_accessor :candidate_rows

	def initialize
		@board = Board.instance
	end

	# def check_rows
	# 	board.rows.each {|square| }
	# 	add_candidate(board.row(1).square(1))
	# end

	def priority_1?(*squares)
		return false if priority_2?(*squares)
		return false if line_full?(*squares)
		true if squares.uniq(&:mark).length == 2 
	end

	def priority_2?(*squares)
		true if squares.map(&:mark).compact.length == 1
	end

	def appearances_of(square)
		candidate_rows.inject(0) do |appearances, row|
			row.include?(square) ? appearances + 1 : appearances
		end
	end

	def line_full?(*squares)
		squares.all? {|square| square.mark }
	end

	def pick_candidates(*squares)
		squares.select {|square| square.mark == nil }
	end

	def pick_lines
		board.columns
		board.rows
		board.diagonals
	end

	def determine_square
		[1,2]
	end

	def rows
		board.rows
	end

	def columns
		board.columns
	end

	def diagonals
		board.diagonals
	end

end