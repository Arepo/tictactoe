require 'mark'

describe Mark do 

	it "can tell which player placed it" do
		mark = Mark.new(:player1)
		expect(mark.origin).to eq :player1
	end
	
end