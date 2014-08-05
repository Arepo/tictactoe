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

	it 'recognises === equality when its contents match a mark' do
		square.mark = :X
		expect(square === :X).to be_truthy
		square.mark = :O
		expect(square === :O).to be_truthy
	end

end