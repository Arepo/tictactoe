require_relative 'player'
require_relative 'win_checker'
# require 'byebug'

class Game

	include WinChecker

	attr_reader :player1, :player2

	def initialize
		super
		create_players
		run_game
	end

	def run_game
		run_turn_for(player1)
		run_turn_for(player2)
	end

	def run_turn_for(player)
		player.your_turn
		display
		completion_check
	end

	def display
		player1.board.display
	end

	private

	def number_of_humans
		puts "How many humans are playing (0, 1 or 2)?"
		gets.chomp.to_i
	end

	def create_players
		# must be a better way of writing this
		case number_of_humans
		when 0
			@player1 = Player.new(human: false)
			@player2 = Player.new(human: false)
		when 1
			@player1 = Player.new
			@player2 = Player.new(human: false)
		when 2
			@player1 = Player.new
			@player2 = Player.new
		end
	end



end