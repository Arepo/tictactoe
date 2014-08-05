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
			return true if row.all? {|square| square == :X } || row.all? {|square| square == :O }
			# return true if row.inject {|last_square, current_square| last_square == current_square}
		end
	end

end