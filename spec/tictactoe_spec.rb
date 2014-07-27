require 'tictactoe'

describe 'TicTacToe' do 

	let(:board){Board.new}

	it 'can create three three-column rows' do
		expect(board.make_row_1.length).to eq 3
		expect(board.make_row_2.length).to eq 3
		expect(board.make_row_3.length).to eq 3
	end

	it 'starts off by doing so' do
		expect(board.row(1).length).to eq 3
	end
	
end