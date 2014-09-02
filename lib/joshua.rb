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
		true if squares.uniq(&:mark).length == 2 unless priority_2?(*squares)
	end

	def priority_2?(*squares)
		true if squares.map(&:mark).compact.length == 1
	end

	def appearances_of(square)
		candidate_rows.inject(0) do |appearances, row|
			row.include?(square) ? appearances + 1 : appearances
		end
	end

	def full_row?(*squares)
		squares.all? {|square| square.mark }
	end

	def pick_candidate(*squares)
		squares.select
	end

	def determine_square
		[1,2]
	end

end