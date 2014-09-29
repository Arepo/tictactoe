require 'game'

describe Game do 

	before do
		Singleton.__init__(Board)
		allow_any_instance_of(Game).to receive(:get_human_count).and_return(2)
		allow_any_instance_of(Player).to receive(:gets).and_return("1","2","3")
		allow_any_instance_of(Game).to receive(:display)
	end

	let(:game){Game.new}

	context 'setup' do

		it 'has two players' do
			expect(game.players[0].is_a? Player).to be true
			expect(game.players[1].is_a? Player).to be true
		end

		it 'creates as many AI players as required, always letting the human play first' do
			allow_any_instance_of(Game).to receive(:get_human_count).and_return(1)
			allow_any_instance_of(Player).to receive(:your_turn)
			game2 = Game.new
			expect(game2.player_1.class).to eq HumanPlayer
			expect(game2.player_2.class).to eq ComputerPlayer
			allow_any_instance_of(Game).to receive(:get_human_count).and_return(0)
			game3 = Game.new
			expect(game3.player_1.class).to eq ComputerPlayer
			expect(game3.player_2.class).to eq ComputerPlayer
		end

	end

	context 'passing control between players' do

		it 'prompting tells each player to take their turn' do
			expect(game.player_1).to receive(:your_turn).ordered
			expect(game.player_2).to receive(:your_turn).ordered
			game.run_game
		end

		it "before doing so states which player it's about to address" do
			expect(game).to receive(:print).with("Player 1: ").ordered
			expect(game).to receive(:print).with("Player 2: ").ordered
			game.run_game
		end

	end

	context 'ending the game' do

		it 'after prompting each player, checks if the board has a completed line' do
			expect(game).to receive(:completed_line?).twice
			allow(game.player_1).to receive(:your_turn)
			allow(game.player_2).to receive(:your_turn)
			game.run_game
		end

		it "checks whether the game is over every time a player takes a turn" do
			expect(game).to receive(:completion_check_for).twice
			allow(game.player_1).to receive(:your_turn)
			allow(game.player_2).to receive(:your_turn)
			game.run_game
		end

		it "terminates the game if it knows a line has been completed" do
			expect(game).to receive(:completed_line?).and_return true
			expect(game).to receive(:exit)
			game.completion_check_for
		end

		it "doesn't terminate the game if no line has been completed" do
			expect(game).not_to receive(:puts)
			expect(game).not_to receive(:exit)
			game.completion_check_for
		end

		it "... unless all squares have been marked" do
			allow(game).to receive(:completed_line?).and_return(false)
			allow(game).to receive(:board_full?).and_return(true)
			expect(game).to receive(:puts).with "A strange game. The only winning move is not to play. How about a nice game of chess?\n\n"
			expect(game).to receive(:exit)
			game.completion_check_for
		end

		it "specifies when player 1 has won" do
			allow(game).to receive(:completed_line?).and_return(true)
			allow(game).to receive(:exit)
			expect(game).to receive(:puts).with "Congratulations Player 1. Your victory will be immortalised by the bards!"
			game.run_turn_for(game.player_1)
		end

		it "specifies when player 2 has won" do
			allow(game).to receive(:completed_line?).and_return(true)
			allow(game).to receive(:exit)
			expect(game).to receive(:puts).with "Congratulations Player 2. Your victory will be immortalised by the bards!"
			game.run_turn_for(game.player_2)
		end

	end

end