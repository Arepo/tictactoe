require 'human'

class HumanTest; include Human; end

describe Human do

	let(:human) {HumanTest.new}

	it "asks the human player for the row they want to play on" do
		expect(human).to receive(:puts).with "Which row would you like to play on (1, 2 or 3)?"
		# game.stub(:gets) {"1"}
		expect(human).to receive(:gets).and_return "1"
		human.get_row
	end

	it "asks the human player for the square they want to play on" do
		expect(human).to receive(:puts).with "And which square (1, 2 or 3)?"
		# game.stub(:gets) {"2"}
		expect(human).to receive(:gets).and_return "2"
		human.get_square
	end

	it "translates the human's coordinates into the relevant square" do
		expect(human).to receive(:get_row).and_return(1)
		expect(human).to receive(:get_square).and_return(2)
		expect(human).to receive(:square_at).with(1, 2)
		allow(human).to receive(:play_on)
		human.your_turn
	end

	it "places their mark on that square" do
		allow(human).to receive(:get_row).and_return(1)
		allow(human).to receive(:get_square).and_return(2)
		allow(human).to receive(:square_at).with(1, 2).and_return(:square)
		expect(human).to receive(:play_on).with(:square)
		human.your_turn
	end

end