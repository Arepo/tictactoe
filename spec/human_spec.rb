require 'human'
require 'byebug'

class HumanTest; include Human; end

describe Human do

	before do
		allow_any_instance_of(Human).to receive(:puts)
	end

	let(:human) {HumanTest.new}

	context "on a human's turn" do

		it "asks the human player for the row they want to play on" do
			expect(human).to receive(:puts).with "Which row would you like to play on (1, 2 or 3)?"
			expect(human).to receive(:gets).and_return "1"
			human.get_row
		end

		it "prompts them again after an invalid answer about rows" do
			allow(human).to receive(:gets).and_return("4", "2")
			expect(human).to receive(:gets).twice
			human.get_row
		end

		it "asks the human player for the square they want to play on" do
			expect(human).to receive(:puts).with "And which square (1, 2 or 3)?"
			expect(human).to receive(:gets).and_return "2"
			human.get_square
		end

		it "prompts them again after an invalid answer about squares" do
			allow(human).to receive(:gets).and_return("4", "2")
			expect(human).to receive(:gets).twice
			human.get_square
		end


		it "translates the human's coordinates into the relevant square" do
			expect(human).to receive(:get_row).and_return(1)
			expect(human).to receive(:get_square).and_return(2)
			expect(human).to receive(:square_at).with(1, 2)
			allow(human).to receive(:play_on).and_return(:square)
			human.your_turn
		end

		it "places their mark on that square" do
			allow(human).to receive(:get_row).and_return(1)
			allow(human).to receive(:get_square).and_return(2)
			allow(human).to receive(:square_at).with(1, 2).and_return(:square)
			expect(human).to receive(:play_on).with(:square).and_return(:square)
			human.your_turn
		end

		it "repeats the process if a player can't play on that square" do
			allow(human).to receive(:get_row).and_return(1,2)
			allow(human).to receive(:get_square).and_return(2,2)
			allow(human).to receive(:square_at).with(1, 2).and_return(:nil)
			allow(human).to receive(:square_at).with(2, 2).and_return(:square)
			allow(human).to receive(:play_on).with(:square).and_return(:square)
			# allow(human).to receive(:play_on).with(any_args()).and_return(nil, :square)
			# allow(human).to receive(:square_at).with(any_args())
			expect(human).to receive(:play_on).twice
			expect(human).to receive(:puts).with "Please make sure you choose an empty square."
			human.your_turn
		end

	end

end