require 'board'

describe Board do 

	let(:board){Board.instance}

	it 'can create a three-column row' do
		expect(board.add_blank_row.length).to eq 3
	end

	it 'starts off by doing so three times' do
		expect(board.row(3).length).to eq 3
	end

	it 'has only one instance' do
		expect{Board.new}.to raise_error
	end


end