require 'game'

describe Game do 

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

	it "can check that there aren't three consecutive marks in a row" do
		expect(game.completed_row?).to be_falsy
	end

	it "can see when there are three consecutive marks in a row" do
		game.player2.play_on(game.board.row(1).square(1))
		game.player2.play_on(game.board.row(1).square(2))
		game.player2.play_on(game.board.row(1).square(3))
		expect(game.completed_row?).to be true
	end
	
end