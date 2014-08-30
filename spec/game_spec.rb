require 'game'

describe Game do 

	before do
		Singleton.__init__(Board)
		allow_any_instance_of(Game).to receive(:number_of_humans).and_return(2)
		allow_any_instance_of(Player).to receive(:gets).and_return("1","2","3")
		allow_any_instance_of(Game).to receive(:display)
	end

	let(:game){Game.new}

	context 'setup' do

		it 'has two players' do
			expect(game.player1.class).to eq Player
			expect(game.player2.class).to eq Player
		end

		# it 'the first of whom marks their squares with an X' do
		# 	game.player1.play_on(game.player1.board.row(1).square(2))
		# 	expect(game.player1.board.row(1).square(2)).to eq :X
		# end

		# it 'the second of whom marks their squares with an O' do
		# 	game.player2.play_on(game.player2.board.row(1).square(2))
		# 	expect(game.player2.board.row(1).square(2)).to eq :O
		# end

		# it 'asks the player whether they want a human opponent' do
		# 	expect(game).to receive(:puts).with "How many humans are playing (0, 1 or 2)?"
		# 	expect(game).to receive(:gets).and_return "1"
		# 	game.number_of_humans
		# end

		it 'creates as many AI players as required, always letting the human play first' do
			allow_any_instance_of(Game).to receive(:number_of_humans).and_return(1)
			allow_any_instance_of(Player).to receive(:your_turn)
			game2 = Game.new
			expect(game2.player1).to respond_to :get_square
			expect(game2.player1).not_to respond_to :determine_square
			expect(game2.player2).to respond_to :determine_square
			expect(game2.player2).not_to respond_to :get_square
		end

	end

	context 'passing control between players' do

		# it 'immediately after creating the board, prompts player1' do
		# 	expect_any_instance_of(Game).to receive(:run_game)
		# 	Game.new
		# end

		it 'prompting tells each player to take their turn' do
			expect(game.player1).to receive(:your_turn).ordered
			expect(game.player2).to receive(:your_turn).ordered
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
			allow(game.player1).to receive(:your_turn)
			allow(game.player2).to receive(:your_turn)
			game.run_game
		end

		it "checks whether the game is over every time a player takes a turn" do
			expect(game).to receive(:completion_check_for).twice
			allow(game.player1).to receive(:your_turn)
			allow(game.player2).to receive(:your_turn)
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
			expect(game).to receive(:puts).with "A strange game. The only winning move is not to play. How about a nice game of chess?"
			expect(game).to receive(:exit)
			game.completion_check_for
		end

		it "specifies when player 1 has won" do
			allow(game).to receive(:completed_line?).and_return(true)
			allow(game).to receive(:exit)
			expect(game).to receive(:puts).with "Congratulations Player 1. Your victory will be immortalised by the bards!"
			game.run_turn_for(game.player1)
		end

		it "specifies when player 2 has won" do
			allow(game).to receive(:completed_line?).and_return(true)
			allow(game).to receive(:exit)
			expect(game).to receive(:puts).with "Congratulations Player 2. Your victory will be immortalised by the bards!"
			game.run_turn_for(game.player2)
		end

	end

end