require 'board'

describe Board do 

	let(:board){Board.instance}

	it 'can create a row' do
		expect(board.add_blank_row.length).to eq 3
	end

	it 'starts off by doing so three times by default' do
		expect(board.row(3).length).to eq 3
	end

	it 'has only one instance' do
		expect{Board.new}.to raise_error
	end

	it 'can return a column' do
		mark = Mark.new(:me)
		board.row(1).square(2).try_to_mark mark
		board.row(2).square(2).try_to_mark mark
		board.row(3).square(2).try_to_mark mark
		expect(board.column(2).length).to eq 3
		expect(board.column(2).all? {|square| square.mark == mark}).to be true
	end

	it 'can return all three columns' do
		expect(board.columns).to eq board.rows.transpose
	end

end