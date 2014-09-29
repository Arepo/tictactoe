require_relative 'human_player'
require_relative 'computer_player'
require_relative 'win_checker'

class Game

	include WinChecker

	attr_reader :player1, :player2, :players

	def initialize
		super
		create_players
		setup_players
		display
	end

	def player_1
		@players[0]
	end

	def player_2
		@players[1]
	end

	def run_game
		print "Player 1: "; run_turn_for(player1)
		print "Player 2: "; run_turn_for(player2)
		# exit
	end

	def run_turn_for(player)
		player.your_turn
		display
		completion_check_for(player)
	end

	def display
		puts "*" * 50 + "\n"
		player1.board.display
		puts "\n" + "*" * 50
	end

	def completion_check_for(player = nil)
		if completed_line?
			puts "Congratulations #{player == player1 ? "Player 1" : "Player 2"}. Your victory will be immortalised by the bards!"
			exit
		elsif board_full?
			puts "A strange game. The only winning move is not to play. How about a nice game of chess?\n\n"
			exit
		end
	end

	private

	def number_of_humans
		puts "How many humans are playing (0, 1 or 2)?"
		gets.chomp.to_i
	end

	def setup_players
		@players = [Player.new, Player.new]
	end

	def create_players
		# must be a better way of writing this
		case number_of_humans
		when 0
			@player1 = ComputerPlayer.new
			@player2 = ComputerPlayer.new
		when 1
			@player1 = HumanPlayer.new
			@player2 = ComputerPlayer.new
		when 2
			@player1 = HumanPlayer.new
			@player2 = HumanPlayer.new
		else
			puts "Please enter 0, 1 or 2"
			create_players
		end
	end

end