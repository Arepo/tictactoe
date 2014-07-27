require 'square'

describe Square do

	let(:board){Board.new}

	xit 'can place a character on the second square' do
		board.row(1).square(2).change_to = "X"
		expect(board.row(1).square(2)).to eq "X"
	end

end