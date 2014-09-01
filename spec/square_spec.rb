require 'square'
require 'byebug'

describe Square do

	let(:board){Board.new}
	let(:square){Square.new}

	# it 'starts with a sourceless mark in it' do
	# 	expect(square.mark.source).to equal nil
	# end

	it 'can place a mark on itself' do
		square.mark_with(:X)
		expect(square.mark).to eq :X
	end

	it "cannot have its mark changed once placed" do
		square.mark_with(:X)
		square.mark_with(:O)
		expect(square.mark).to eq :X
	end

	it "will not acknowledge placement if something has already been placed there" do
		square.mark_with(:X)
		expect(square.mark_with(:O)).to eq nil
	end

	it "recognises == and eql? equality when its mark's source matches another square's mark's source" do
		mark = Mark.new(:me)
		other_square = Square.new
		square.mark_with(mark)
		other_square.mark_with(mark)
		expect(square == other_square).to be true
		# expect(square.eql? other_square).to be true
	end

	it 'its string version is an underscore if no player has marked it' do
		expect(square.to_s).to eq "_"
	end

	it "displays the string version of its mark if a player has marked it" do
		mark = double 
		square.mark_with(mark)
		expect(mark).to receive(:to_s)
		square.to_s
	end

	xit "can compare squares by the string version of their marks" do
		square.mark_with(:x)
		square2 = Square.new
		square2.mark_with(:o)
		square3 = Square.new
		expect([square, square2, square3])
	end

end