require_relative 'player'

class ComputerPlayer < Player

	attr_reader :board

	def candidate_lines
		@candidate_lines ||= []
	end

	def candidate_squares
		@candidate_squares ||= [] 
	end

	def empty_lines
		@empty_lines ||= [] 
	end

	def active_lines
		@active_lines = (candidate_lines + empty_lines)
	end

	def initialize
		@board = Board.instance
	end

	def your_turn
		clear_previous_candidates
		prioritise_lines
		puts "The computer moves:"
		return if playing_on_priority_1_line
		return if playing_on_priority_2_line
		return if playing_on_empty_line
		return playing_on_leftover_square
	end

	def clear_previous_candidates
		[candidate_lines, empty_lines, candidate_squares, active_lines].each do |dataset| 
			dataset.clear
		end
	end

	def playing_on_priority_1_line
		if !candidate_lines.empty? && priority_1?(candidate_lines.first)
			candidate_lines.replace(his_own_line) 
			play_on(vacant_squares_in(candidate_lines).first)
		end
	end
	
	def playing_on_priority_2_line
		if !candidate_lines.empty? && priority_2?(candidate_lines.first)
			candidate_squares.replace(vacant_squares_in(candidate_lines).uniq)
			play_on(random_square_from(final_candidates))
		end
	end

	def playing_on_empty_line
		unless empty_lines.empty?
			play_on(random_square_from(empty_lines.flatten.get_mode))
		end
	end

	def playing_on_leftover_square
		play_on(random_square_from(vacant_squares_in(rows)))
	end

	def prioritise_lines
		flag_lines_of(:priority_1?)
		note_empty_lines && flag_lines_of(:priority_2?) if candidate_lines.empty?
	end

	def note_empty_lines
		[rows, columns, diagonals].each do |lines|
			lines.each {|line| empty_lines << line if priority_3?(line) }
		end
	end

	def flag_lines_of(priority_level)
		[rows, columns, diagonals].each do |lines|
			lines.each {|line| candidate_lines << line if eval("#{priority_level}(line)") }
		end
	end

	def priority_1?(squares)
		return false if priority_2?(squares)
		return false if line_full?(squares)
		true if squares.uniq(&:mark).length == 2 
	end

	def priority_2?(squares)
		true if squares.map(&:mark).compact.length == 1
	end

	def priority_3?(squares)
		true if squares.none?(&:mark)
	end

	def line_full?(squares)
		squares.all? {|square| square.mark }
	end

	def vacant_squares_in(*squares)
		squares.flatten.reject(&:mark)
	end

	def his_own_line
		candidate_lines.each {|line| return line if line.marked_by?(self) && priority_1?(line) }
		# test for this line is inadequate:
		candidate_lines.each {|line| return line if priority_1?(line) }
	end

	def recurring_candidate_squares
		active_lines.flatten.select do |square| 
			candidate_squares.any? {|candidate| candidate.equal?(square)}
		end
	end

	def final_candidates
		recurring_candidate_squares.get_mode
	end

	def random_square_from(squares)
		squares.sample
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