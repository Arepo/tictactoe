require 'square'

describe Square do

	let(:board){Board.new}
	let(:square){Square.new}

	it 'starts with nothing in it' do
		expect(square.mark).to eq nil
	end

	it 'can place a character on itself' do
		square.mark = :X
		expect(square.mark).to eq :X
	end

	it 'can check for equality with a string with the same contents as it' do
		square.mark = :X
		expect(square === :X).to be_truthy
		square.mark = :O
		expect(square === :O).to be_truthy
	end

end