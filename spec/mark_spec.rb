require 'mark'

describe Mark do

	it "can tell which player placed it" do
		mark = Mark.new(:player1)
		expect(mark.source).to eq :player1
	end

	it "has a unique string representation - the first is X, the second is O" do
		mark1 = Mark.new
		mark2 = Mark.new
		expect(mark1.to_s).to eq "X"
		expect(mark2.to_s).to eq "O"
	end
	
end