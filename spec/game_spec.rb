require 'game'

describe 'TicTacToe' do 

	let(:game){Game.new}

	it 'can create a three-column row' do
		expect(game.add_blank_row.length).to eq 3
	end

	it 'starts off by doing so three times' do
		expect(game.row(3).length).to eq 3
	end

	it 'can output its squares as a tictactoe player would expect' do
		expect(game.row(1))
	end


	
end