require_relative 'spec_helper'

describe ComputerPlayer do 

	before do
		Singleton.__init__(Board)
	end

	let(:joshua) {ComputerPlayer.new}
	let(:square0) {double :square, mark: nil}
	let(:square1) {double :square, mark: :x}
	let(:square2) {double :square, mark: :o}
	let(:square3) {double :square, mark: nil}
	let(:square4) {double :square, mark: nil}
	let(:square5) {double :square, mark: nil}

	context "looking through lines" do

		it "at the start of its turn clears the data from any previous turns" do
			ignore(:prioritise_lines, :playing_on_priority_1_line, :playing_on_priority_2_line, :playing_on_empty_line, :playing_on_leftover_square)
			joshua.candidate_lines << [:line]
			joshua.candidate_squares << [:square]
			joshua.empty_lines << [:line]
			joshua.active_lines << [:line]
			joshua.your_turn
			expect(joshua.candidate_lines + joshua.empty_lines + joshua.candidate_squares + joshua.active_lines).to be_empty
		end

		it "can look at the board's rows" do
			expect(joshua.rows).to eq(joshua.board.rows)
		end

		it "can look at the board's diagonals" do
			expect(joshua.diagonals).to eq(joshua.board.diagonals)
		end

		it "can look at the board's columns" do
			expect(joshua.columns).to eq(joshua.board.columns)
		end

		it "can tell if a set of three squares has two marked identically and one unmarked,
			and considers it top priority" do
			expect(joshua.priority_1?([square1, square1, square2])).to be_falsy
			expect(joshua.priority_1?([square1, square2, square0])).to be_falsy
			expect(joshua.priority_1?([square1, square1, square1])).to be_falsy
			expect(joshua.priority_1?([square0, square0, square0])).to be_falsy
			expect(joshua.priority_1?([square0, square0, square1])).to be_falsy
			expect(joshua.priority_1?([square0, square2, square2])).to be true
		end

		it "can tell if a set of three squares has exactly 1 square marked, 
			and considers it second priority" do
			expect(joshua.priority_2?([square1, square0, square0])).to be true
			expect(joshua.priority_2?([square1, square1, square0])).to be_falsy
			expect(joshua.priority_2?([square1, square2, square0])).to be_falsy
			expect(joshua.priority_2?([square0, square0, square0])).to be_falsy
		end

		it "can tell if a set of three squares has none marked, and considers it third priority" do
			expect(joshua.priority_3?([square1, square0, square0])).to be_falsy
			expect(joshua.priority_3?([square1, square1, square0])).to be_falsy
			expect(joshua.priority_3?([square1, square2, square0])).to be_falsy
			expect(joshua.priority_3?([square0, square0, square0])).to be true
		end

		it "looks through all the lines, and doesn't record any as priority 1 or 
			priority 2 if none are." do
			expect(joshua).to receive(:priority_1?).exactly(8).times.and_return(false)
			expect(joshua).to receive(:priority_2?).exactly(8).times.and_return(false)
			ignore(:priority_3?)
			joshua.prioritise_lines
			expect(joshua.candidate_lines.length).to eq 0
		end

		it "looks through all the lines and records (the) one if one priority 1" do
			produce_one_(:priority_1?)
			no_priority_twos
			joshua.prioritise_lines
			expect(joshua.candidate_lines.length).to eq 1
			expect(joshua.candidate_lines).to include(joshua.board.row(1))
		end

		it "looks through all the lines and records each one iff it's priority 1" do
			allow(joshua).to receive(:priority_1?).exactly(8).times.and_return(*three_positives)
			no_priority_twos
			joshua.prioritise_lines
			check_lines_registered
		end

		it "does not record any priority 2 lines if it finds any of priority 1" do
			produce_one_(:priority_1?)
			expect(joshua).not_to receive(:priority_2?)
			joshua.prioritise_lines
		end

		it "otherwise records the priority 2 line if one is" do
			no_priority_ones
			expect(joshua).to receive(:priority_2?).exactly(8).times.and_return(*one_positive)
			joshua.prioritise_lines
			expect(joshua.candidate_lines.length).to eq 1
			expect(joshua.candidate_lines).to include(joshua.board.row(1))
		end

		it "otherwise records all the priority 2 lines if there are more than one" do
			no_priority_ones
			expect(joshua).to receive(:priority_2?).exactly(8).times.and_return(*three_positives)
			joshua.prioritise_lines
			check_lines_registered
		end

		it "otherwise records a priority 3 (ie empty) line if there is one" do
			no_priority_ones
			no_priority_twos
			expect(joshua).to receive(:priority_3?).exactly(8).times.and_return(*one_positive)
			joshua.prioritise_lines
			expect(joshua.empty_lines.length).to eq 1
			expect(joshua.empty_lines).to include(joshua.board.row(1))
		end

		it "otherwise records multiple priority 3 lines if there are any" do
			no_priority_ones
			no_priority_twos
			expect(joshua).to receive(:priority_3?).exactly(8).times.and_return(*three_positives)
			joshua.prioritise_lines
			check_lines_registered(:empty_lines)
		end

	end

	context "choosing among candidate lines" do

		it "chooses among equal priority 1 lines by the one which contains its mark(s)" do
			line1 = double :line, marked_by?: false
			line2 = double :line, marked_by?: true
			allow(joshua).to receive(:priority_1?).and_return(true)
			expect(joshua).to receive(:candidate_lines).and_return([line1, line2])
			expect(joshua.his_own_line).to eq line2
		end

		it "if no priority 1 lines contain its mark, chooses any remaining priority 1 line" do
			line1 = double :line, marked_by?: false, uniq: [:is, :priority_1]
			line2 = double :line, marked_by?: false
			ignore(:priority_2?, :line_full?)
			expect(joshua).to receive(:candidate_lines).twice.and_return([line1, line2])
			expect(joshua.his_own_line).to eq line1
		end

	end

	context "picking out squares" do

		it "can tell if a set of squares is full" do
			expect(joshua.line_full?([square1, square1, square0])).to be_falsy
			expect(joshua.line_full?([square1, square1, square1])).to be true
			expect(joshua.line_full?([square1, square2, square0])).to be_falsy
		end

		it "selects the empty square from a set of three" do
			expect(joshua.vacant_squares_in(square1, square1, square0)).to eq [square0]
			expect(joshua.vacant_squares_in(square2, square2, square2)).to eq []
			expect(joshua.vacant_squares_in(square1, square2, square0)).to eq [square0]
		end

		it "can pick an empty square at random from a set of 1 or more" do
			expect(joshua.candidate_squares).to receive(:sample)
			joshua.random_square_from(joshua.candidate_squares)
		end

		it "notes each unmarked square from the priority 2 lines as a candidate square" do
			joshua.candidate_lines << [square1, square0, square3]
			joshua.candidate_lines << [square1, square0, square4]
			ignore(:clear_previous_candidates, :priority_1?, :play_on)
			accept_and_mimic(:priority_2?)
			joshua.your_turn
			expect(joshua.candidate_squares).to eq [square0, square3, square4]
		end

		it "saves all the lines from candidate lines and empty lines key lines together" do
			joshua.candidate_lines << [square1, square2]
			joshua.empty_lines << [square2]
			expect(joshua.active_lines).to eq([[square1, square2], [square2]])
		end

		it "having noted some squares as candidates, can select only those squares from the key lines" do
			joshua.candidate_squares.push(square0, square3)
			joshua.candidate_lines.push([square3], [square0, square3])
			joshua.empty_lines.push([square0, square4])
			expect(joshua.recurring_candidate_squares).to eq [square3, square0, square3, square0]
		end

		it "can check the frequency with which candidate squares appear in priority 2 and empty lines" do
			expect(joshua).to receive(:recurring_candidate_squares).and_return([square3, square0, square3, square0, square4])
			expect(joshua.final_candidates).to eq [square3, square0]
		end

	end

	context "high level turn process" do

		it "on being prompted for its turn, prioritises lines from the grid" do
			ignore(:playing_on_priority_1_line, :playing_on_priority_1_line, :playing_on_empty_line, :playing_on_leftover_square)
			ensure_joshua_receives(:prioritise_lines)
			joshua.your_turn
		end

		it "if it's found priority one lines, chooses its own and saves it as the only candidate line" do
			line1 = [square1, square1, square0]
			line2 = [square2, square2, square0]
			joshua.candidate_lines << line1
			joshua.candidate_lines << line2
			ignore(:clear_previous_candidates, :prioritise_lines)
			expect(joshua).to receive(:his_own_line).and_return(line2)
			accept_and_mimic(:play_on)
			joshua.your_turn
			expect(joshua.candidate_lines).to eq line2
		end

		it "does not update candidate lines if it doesn't find any priority ones" do
			ignore(:playing_on_empty_line, :playing_on_leftover_square)
			expect(joshua.candidate_lines).not_to receive(:replace)
			joshua.your_turn
		end

		it "if it has found a priority one line, plays on the line's free square" do
			ignore(:prioritise_lines)
			accept_and_mimic(:candidate_lines, :priority_1?, :his_own_line, :vacant_squares_in)
			expect(joshua).to receive(:play_on).with(square0).and_return true
			joshua.your_turn
		end

		it "if it has found any priority two lines, notes the empty squares from them" do
			ignore(:clear_previous_candidates, :prioritise_lines, :playing_on_priority_1_line)
			accept_and_mimic(:priority_2?, :play_on, :candidate_lines)
			expect(square0).to receive :uniq
			ensure_joshua_receives(:priority_2?)
			expect(joshua.candidate_squares).to receive(:replace)
			expect(joshua).to receive(:vacant_squares_in).with([square0]).and_return square0
			joshua.your_turn
		end

		it "then plays randomly on the priority 2 squares common to the most lines" do
			ignore(:clear_previous_candidates, :prioritise_lines, :priority_1?)
			accept_and_mimic(:candidate_lines, :priority_2?)
			ensure_joshua_receives(:random_square_from, :final_candidates, :play_on)
			joshua.your_turn
		end

		it "if no priority 1 or two lines, plays on a square common to as many empty lines as possible, if there are any empty lines" do
			ignore(:clear_previous_candidates, :prioritise_lines)
			expect(joshua).to receive(:empty_lines).twice.and_return([:line1, :line2])
			ensure_joshua_receives(:random_square_from, :play_on)
			joshua.your_turn
		end

		it "if nothing else left, plays on a random empty square" do
			ignore(:playing_on_priority_1_line, :playing_on_priority_2_line, :playing_on_empty_line)
			expect(joshua).to receive(:rows).exactly(4).times.and_return(joshua.rows)
			ensure_joshua_receives(:vacant_squares_in, :random_square_from, :play_on)
			joshua.your_turn
		end

		it "playing on a square, updates the board to have its mark on that square" do
			joshua.your_turn
			# joshua's turn on an empty board should always be to 
			# play on the centre square (he's not very sporting)
			expect(joshua.board.row(2).square(2).source).to eq joshua
		end

	end

	def ignore(*methods)
		methods.each { |method| allow(joshua).to receive(method) }
	end

	def accept_and_mimic(*methods)
		methods.each { |method| allow(joshua).to receive(method).and_return([square0]) }
	end

	def ensure_joshua_receives(*methods)
		methods.each { |method| expect(joshua).to receive(method).and_return(true) }
	end

	def no_priority_twos
		allow(joshua).to receive(:priority_2?).and_return(false)
	end

	def no_priority_ones
		allow(joshua).to receive(:priority_1?).and_return(false)
	end

	def three_positives
		[false, true, false, false, true, false, true, false]
	end

	def one_positive
		[true].fill(false, 1..7)
	end

	def produce_one_(priority_n)
		allow(joshua).to receive(priority_n).exactly(9).times.and_return(*one_positive)
	end

	def check_lines_registered(lines = :candidate_lines)
		expect(eval("joshua.#{lines}.length")).to eq 3
		expect(eval("joshua.#{lines}")).to include(joshua.board.row(2))
		expect(eval("joshua.#{lines}")).to include(joshua.board.column(2))
		expect(eval("joshua.#{lines}")).to include(joshua.board.diagonals.first)
	end

end