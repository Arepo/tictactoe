require_relative 'board'

module Joshua

	attr_reader :board

	def candidate_lines
		@candidate_lines ||= []
	end

	def candidate_squares
		@candidate_squares ||= [] 
	end

	def initialize
		@board = Board.instance
	end

	def your_turn
		prioritise_lines
		candidate_lines.replace(choose_own_line) if priority_1?(*candidate_lines.first)
	end

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
		candidate_lines.inject(0) do |appearances, row|
			row.include?(square) ? appearances + 1 : appearances
		end
	end

	def line_full?(*squares)
		squares.all? {|square| square.mark }
	end

	def vacant_squares(*squares)
		squares.select {|square| square.mark == nil }
	end

	def prioritise_lines
		note_lines_of(:priority_1?)
		note_lines_of(:priority_2?) if candidate_lines.empty?
		note_lines_of(:priority_3?) if candidate_lines.empty?
	end

	def choose_own_line
		candidate_lines.each {|line| return line if line.marked_by?(self) && priority_1?(line) }
		candidate_lines.each {|line| return line if priority_1?(*line) }
		# candidate_lines.select {|line| line.marked_by? self }
	end

	def random_tiebreak
		candidate_squares.sample
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

	def note_lines_of(priority_level)
		[rows, columns, diagonals].each do |lines|
			lines.each {|line| candidate_lines << line if eval("#{priority_level}(*line)") }
		end
	end

end