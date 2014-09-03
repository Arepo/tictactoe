require_relative 'board'

module Joshua

	attr_reader :board
	attr_accessor :candidate_rows

	def candidate_lines
		@candidate_lines ||= []
	end

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

	def priority_3?(*squares)
		true if squares.none?(&:mark)
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

	def prioritise_lines
		find_priority_1s
		find_priority_2s if candidate_lines.empty?
		find_priority_3s if candidate_lines.empty?
	end

	def tiebreak_lines
		candidate_lines.each {|line| return line if line.marked_by?(self) && priority_1?(line) }
		candidate_lines.select {|line| line.marked_by? self }
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

	def find_priority_1s
		[rows, columns, diagonals].each do |lines|
			 lines.each {|line| candidate_lines << line if priority_1?(line) }
		end
		# if candidate_lines.none? {|line| priority_1?(line) }
		# 	lines.each do |line|
		# 		candidate_lines << line if priority_2?(line)
		# 	end
		# end
		# if candidate_lines.none? {|line| priority_2?(line) }
		# 	lines.each {|line| candidate_lines << line if priority_3?(line) }
		# end
	end

	def find_priority_2s
		[rows, columns, diagonals].each do |lines|
			lines.each {|line| candidate_lines << line if priority_2?(line) }
		end
	end

	def find_priority_3s
		[rows, columns, diagonals].each do |lines|
			lines.each {|line| candidate_lines << line if priority_3?(line) }
		end
	end

end