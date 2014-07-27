require 'square'

describe Square do

	let(:board){Board.new}
	let(:square){Square.new}

	it 'starts with nothing in it' do
		expect(square.mark).to eq nil
	end

	it 'can place a character on itself' do
		square.mark = "X"
		expect(square.mark).to eq "X"
	end

end