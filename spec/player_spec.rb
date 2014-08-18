require 'player'

describe Player do 

	let(:malcolm){Player.new}
	let(:inara)  {Player.new(:O)}
	let(:square) {Square.new}

	it 'can place its X mark on a square' do
		malcolm.play_on(square)
		expect(square == :X).to be true
	end

	it 'can have O as its mark and play that on a square' do
		inara.play_on(square)
		expect(square == :O).to be true
	end

	it 'has access to the same board as his/her opponent' do
		expect(inara.board).to be(malcolm.board)
	end

	it "can translates row/square coordinates into the square at them" do
		expect(malcolm.square_at(1, 2)).to equal malcolm.board.row(1).square(2)
		expect(malcolm.square_at(2, 3)).to equal malcolm.board.row(2).square(3)
	end

end