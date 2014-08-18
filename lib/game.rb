require_relative 'player'
require_relative 'win_checker'
# require 'byebug'

class Game

	attr_reader :player1, :player2

	include WinChecker

	def initialize
		create_players
		prompt
	end

	def prompt
		player1.your_turn
		player2.your_turn
	end

	private

	def number_of_humans
		puts "How many humans are playing (0, 1 or 2)?"
		gets.chomp.to_i
	end

	def create_players
		case number_of_humans
		when 0
			@player1 = Player.new(:X, human: false)
			@player2 = Player.new(:O, human: false)
		when 1
			@player1 = Player.new
			@player2 = Player.new(:O, human: false)
		when 2
			@player1 = Player.new
			@player2 = Player.new(:O)
		end
	end

end