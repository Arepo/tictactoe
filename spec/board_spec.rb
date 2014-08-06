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

	it 'can return a column' do
		board.row(1).square(2).mark = :X
		board.row(2).square(2).mark = :X
		board.row(3).square(2).mark = :X
		expect(board.column(2).all? {|square| square == :X}).to be true
	end

	it 'can return all three columns' do
		expect(board.columns).to eq board.rows.transpose
	end

end