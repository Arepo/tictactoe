require 'player'

describe Player do

	let(:malcolm){Player.new}
	let(:inara)  {Player.new}
	let(:square) {Square.new}

	it 'can place its identifying mark on a square' do
		malcolm.play_on(square)
		expect(square.mark.source).to equal malcolm
		expect(square.mark.source).not_to equal inara
	end

	it 'has access to the same board as his/her opponent' do
		expect(inara.board).to be(malcolm.board)
	end

	it "can translate row/square coordinates into the square at them" do
		expect(malcolm.square_at(1, 2)).to equal malcolm.board.row(1).square(2)
		expect(malcolm.square_at(2, 3)).to equal malcolm.board.row(2).square(3)
	end

	it 'raises a notimplemented error if someone calls your_turn on it' do
		expect{malcolm.your_turn}.to raise_error(NotImplementedError)
	end

end