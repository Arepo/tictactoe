require 'game'

describe Game do 

	before do
    	Singleton.__init__(Board)
  	end

	let(:game){Game.new}

	it 'has two players' do
		expect(game.player1.class).to eq Player
		expect(game.player2.class).to eq Player
	end

	it 'the first of whom marks their squares with an X' do
		game.player1.play_on(game.player1.board.row(1).square(2))
		expect(game.player1.board.row(1).square(2)).to eq :X
	end

	it 'the second of whom marks their squares with an O' do
		game.player2.play_on(game.player2.board.row(1).square(2))
		expect(game.player2.board.row(1).square(2)).to eq :O
	end

	it "asks the player for the row they want to play on" do
		expect(game).to receive(:puts).with "Which row would you like to play on (1, 2 or 3)?"
		game.stub(:gets) {"1"}
		expect(game).to receive(:gets).and_return "1"
		game.get_row
	end

	it "asks the player for the square they want to play on" do
		expect(game).to receive(:puts).with "And which square (1, 2 or 3)?"
		game.stub(:gets) {"2"}
		expect(game).to receive(:gets).and_return "1"
		game.get_square
	end

	# it 'testing double' do
	# 	player3 = double :player
	# 	allow(player3).to receive(:play_on)
	# 	game.prompt
	# end

end