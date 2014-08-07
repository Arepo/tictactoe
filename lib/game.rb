require_relative 'player'
require_relative 'win_checker'

class Game

	attr_reader :player1, :player2

	include WinChecker

	def initialize
		@player1 = Player.new
		@player2 = Player.new(:O)
	end

end