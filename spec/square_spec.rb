require 'square'
require 'byebug'

describe Square do

	let(:board){Board.new}
	let(:square){Square.new}

	# it 'starts with a sourceless mark in it' do
	# 	expect(square.mark.source).to equal nil
	# end

	it 'can place a mark on itself' do
		square.mark = :X
		expect(square.mark).to eq :X
	end

	it "recognises == equality when its mark's source matches another square's mark's source" do
		mark = Mark.new(:me)
		other_square = Square.new
		square.mark = mark
		other_square.mark = mark
		expect(square == other_square).to be true
	end

	it 'its string version is an underscore if no player has marked it' do
		expect(square.to_s).to eq "_"
	end

	it "displays the string version of its mark if a player has marked it" do
		mark = double 
		square.mark = mark
		expect(mark).to receive(:to_s)
		square.to_s
	end

	it "cannot have its mark changed once placed" do
		square.mark = :X
		square.mark = :O
		expect(square.mark).to eq :X
	end

end