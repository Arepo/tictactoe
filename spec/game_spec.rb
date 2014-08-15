require 'game'

describe Game do 

	before do
    	Singleton.__init__(Board)
    	Game.any_instance.stub(:number_of_humans).and_return(1)
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

	it 'asks the player whether they want a human opponent' do
		expect(game).to receive(:puts).with "How many humans are playing (0, 1 or 2)?"
		expect(game).to receive(:gets).and_return "1"
		game.number_of_humans
	end

	it 'creates as many AI players as required, always letting the human play first' do
		allow(game).to receive(:gets).and_return "1"
		game.number_of_humans
		expect(game.player1).to respond_to :get_square
		expect(game.player2).to respond_to :determine_square
	end

	# it 'testing double' do
	# 	player3 = double :player
	# 	allow(player3).to receive(:play_on)
	# 	game.prompt
	# end

end