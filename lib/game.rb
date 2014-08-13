require_relative 'player'
require_relative 'win_checker'

class Game

	attr_reader :player1, :player2

	include WinChecker

	def initialize
		@player1 = Player.new
		@player2 = Player.new(:O)
	end

	def get_row
		puts "Which row would you like to play on (1, 2 or 3)?"
		chosen_row = gets.chomp
		# puts "Which square? (1, 2 or 3)"
		# chosen_square = gets.chomp
	end

	def get_square
		puts "And which square (1, 2 or 3)?"
		chosen_square = gets.chomp
	end

	# def p1_turn?
	# 	true
	# end

end