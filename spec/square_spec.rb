require 'square'
require 'byebug'

describe Square do

	let(:board){Board.new}
	let(:square){Square.new}

	# it 'starts with a sourceless mark in it' do
	# 	expect(square.mark.source).to equal nil
	# end

	it 'can place a mark on itself' do
		square.try_to_mark(:X)
		expect(square.mark).to eq :X
	end

	it "cannot have its mark changed once placed" do
		square.try_to_mark(:X)
		square.try_to_mark(:O)
		expect(square.mark).to eq :X
	end

	it "will not acknowledge placement if something has already been placed there" do
		square.try_to_mark(:X)
		expect(square.try_to_mark(:O)).to eq nil
	end

	it "recognises == equality when its mark's source matches another square's mark's source" do
		mark = Mark.new(:me)
		other_square = Square.new
		square.try_to_mark(mark)
		other_square.try_to_mark(mark)
		expect(square == other_square).to be true
	end

	it 'its string version is an underscore if no player has marked it' do
		expect(square.to_s).to eq "_"
	end

	it "displays the string version of its mark if a player has marked it" do
		mark = double 
		square.try_to_mark(mark)
		expect(mark).to receive(:to_s)
		square.to_s
	end

	it "does not complete a player's turn if they try to overwrite an existing mark" do

	end

end