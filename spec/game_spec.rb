require 'game'

describe Game do 

	let(:game){Game.new}

	it 'has two players' do
		expect(game.player1.class).to eq Player
		expect(game.player2.class).to eq Player
	end

	it 'the first of whom marks their squares with an X' do
		game.player1.play_on(game.player1.board.row(1).square(2))
		expect(game.player1.board.row(1).square(2)).to eq
	end
	
end