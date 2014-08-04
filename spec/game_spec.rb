require 'game'

describe 'TicTacToe' do 

	let(:game){Game.new}

	it 'can create a three-column row' do
		expect(game.add_blank_row.length).to eq 3
	end

	it 'starts off by doing so three times' do
		expect(game.row(3).length).to eq 3
	end

	it 'has only one instance' do
		expect{Game.new}.to raise_error
	end
	
end