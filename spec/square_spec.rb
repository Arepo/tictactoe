require 'square'

describe Square do

	let(:board){Board.new}
	let(:square){Square.new}

	it 'starts with no source of the mark in it' do
		expect(square.mark.source).to equal nil
	end

	it 'can place a character on itself' do
		square.mark = :X
		expect(square.mark).to eq :X
	end

	it 'recognises == equality when its contents match a mark' do
		mark = Mark.new(:me)
		square.mark = mark
		expect(square == mark).to be true
	end

end