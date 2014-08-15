require_relative 'player'
require_relative 'win_checker'

class Game

	attr_reader :player1, :player2

	include WinChecker

	def initialize
		number_of_humans.times
		@player1 = Player.new
		@player2 = Player.new(:O)
	end

	private

	def number_of_humans
		puts "How many humans are playing (0, 1 or 2)?"
		gets.chomp
	end

end