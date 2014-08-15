require 'joshua'

class JoshuaTest; include Joshua; end

describe Joshua do

	let(:joshua) {JoshuaTest.new}

	it "specifies the row and square it's going to play on" do
		expect(joshua.determine_square.class).to eq Array
	end

end