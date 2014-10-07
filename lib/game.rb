require_relative 'human_player'
require_relative 'computer_player'
require_relative 'win_checker'

class Game

	include WinChecker

	attr_reader :player1, :player2

	def initialize
		super
		setup_players(get_human_count)
		display
	end

	def player_1
		@players[0]
	end

	def player_2
		@players[1]
	end

	def players
		@players ||= []
	end

	def run_game
		print "Player 1: "; run_turn_for(player_1)
		print "Player 2: "; run_turn_for(player_2)
	end

	def run_turn_for(player)
		player.your_turn
		display
		completion_check_for(player)
	end

	def completion_check_for(player = nil)
		if completed_line?
			puts "Congratulations #{player == player_1 ? "Player 1" : "Player 2"}. Your victory will be immortalised by the bards!"
			exit
		elsif board_full?
			puts "A strange game. The only winning move is not to play. How about a nice game of chess?\n\n"
			exit
		end
	end

	private

	def display
		puts "*" * 50 + "\n"
		player_1.board.display
		puts "\n" + "*" * 50
	end

	def get_human_count
		puts "How many humans are playing (0, 1 or 2)?"
		gets.chomp.to_i
	end

	def setup_players(human_count)
		human_count.times {players << HumanPlayer.new}
		(2 - human_count).times {players << ComputerPlayer.new}
	end

end