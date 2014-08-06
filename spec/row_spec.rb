require 'row'

describe 'row' do

	let(:board){Board.instance}

	it 'can refer to each square ' do
		expect(board.row(1).square(3).class).to be Square
		expect(board.row(1).square(1).class).to be Square
	end

end