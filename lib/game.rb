require_relative 'player'

class Game

	attr_reader :player1, :player2, :board

	def initialize
		@player1 = Player.new
		@player2 = Player.new(:O)
		@board = Board.instance
	end

	def completed_row?
		board.rows.any? do |row|
			equivalent_squares_in?(row)
			# return true if row.all? {|square| square == :O }
		end
	end

	def completed_column?
		board.columns.any? do |column|
			equivalent_squares_in?(column)
		end
	end

	def equivalent_squares_in?(squares)
		return true if squares.inject do |last_square, this_square| 
			last_square == this_square ? this_square : false 
		end
	end

end