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



end