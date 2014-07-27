require 'row.rb'

describe Row do

	let(:board){Board.new}

	it 'can refer to each square ' do
		expect(board.row(1).first_square).to eq board.row(1)[0]
		expect(board.row(1).second_square).to eq board.row(1)[1]
		expect(board.row(1).third_square).to eq board.row(1)[2]
		expect(board.row(1).square(3)).to eq (board.row(1).third_square)
		expect(board.row(1).square(1)).to eq (board.row(1).first_square)
	end

end