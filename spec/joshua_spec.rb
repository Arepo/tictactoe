require 'joshua'
require 'byebug'

class JoshuaTest; include Joshua; end

describe Joshua do

	before do
		Singleton.__init__(Board)
	end

	let(:joshua) {JoshuaTest.new}
	let(:square0) {double :square, mark: nil}
	let(:square1) {double :square, mark: :x}
	let(:square2) {double :square, mark: :o}

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

	def check_lines_registered
		expect(joshua.candidate_lines.length).to eq 3
		expect(joshua.candidate_lines).to include(joshua.board.row(2))
		expect(joshua.candidate_lines).to include(joshua.board.column(2))
		expect(joshua.candidate_lines).to include(joshua.board.diagonals.first)
	end

	xit "specifies the row and square it's going to play on" do
		expect(joshua.determine_square.class).to eq Array
	end

	context "picking out squares" do

		it "can tell how many times a square features in multiple sets of squares" do
			row1 = [:square1, :circle, :circle]
			row2 = [:square2, :circle, :circle]
			row3 = [:circle, :square2, :circle]
			joshua.candidate_rows = [row1, row2, row3]
			expect(joshua.appearances_of(:square1)).to eq 1
			expect(joshua.appearances_of(:square2)).to eq 2
		end

		it "can tell if a set of squares is full" do
			expect(joshua.line_full?(square1, square1, square0)).to be_falsy
			expect(joshua.line_full?(square1, square1, square1)).to be true
			expect(joshua.line_full?(square1, square2, square0)).to be_falsy
			expect(joshua.line_full?(square2, square2, square2)).to be true
		end

		it "selects the empty square from a set of three" do
			expect(joshua.pick_candidates(square1, square1, square0)).to eq [square0]
			expect(joshua.pick_candidates(square2, square2, square0)).to eq [square0]
			expect(joshua.pick_candidates(square2, square2, square2)).to eq []
			expect(joshua.pick_candidates(square1, square2, square0)).to eq [square0]
		end

	end

	context "looking through lines" do

		it "can look at the board's rows" do
			expect(joshua.rows).to eq(joshua.board.rows)
		end

		it "can look at the board's diagonals" do
			expect(joshua.diagonals).to eq(joshua.board.diagonals)
		end

		it "can look at the board's columns" do
			expect(joshua.columns).to eq(joshua.board.columns)
		end

		it "can tell if a set of three squares has exactly two marked, that == each other,
			and considers it top priority" do
			expect(joshua.priority_1?(square1, square1, square2)).to be_falsy
			expect(joshua.priority_1?(square1, square2, square0)).to be_falsy
			expect(joshua.priority_1?(square1, square1, square1)).to be_falsy
			expect(joshua.priority_1?(square0, square0, square0)).to be_falsy
			expect(joshua.priority_1?(square0, square0, square1)).to be_falsy
			expect(joshua.priority_1?(square0, square2, square2)).to be true
		end

		it "can tell if a set of three squares has exactly 1 square marked, 
			and considers it second priority" do
			expect(joshua.priority_2?(square1, square0, square0)).to be true
			expect(joshua.priority_2?(square1, square1, square0)).to be_falsy
			expect(joshua.priority_2?(square1, square2, square0)).to be_falsy
			expect(joshua.priority_2?(square0, square0, square0)).to be_falsy
		end

		it "can tell if a set of three squares has none marked, and considers it third priority" do
			expect(joshua.priority_3?(square1, square0, square0)).to be_falsy
			expect(joshua.priority_3?(square0, square2, square0)).to be_falsy
			expect(joshua.priority_3?(square1, square1, square0)).to be_falsy
			expect(joshua.priority_3?(square1, square2, square0)).to be_falsy
			expect(joshua.priority_3?(square0, square0, square0)).to be true
		end

		it "looks through all the lines, and doesn't record any as priority 1 or 
			priority 2 if none are." do
			expect(joshua).to receive(:priority_1?).exactly(8).times.and_return(false)
			expect(joshua).to receive(:priority_2?).exactly(8).times.and_return(false)
			allow(joshua).to receive(:priority_3?).exactly(8).times.and_return(false)
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

		it "does not record any priority 3 lines if there are any of priority 1" do
			produce_one_(:priority_1?)
			expect(joshua).not_to receive(:priority_3?)
			joshua.prioritise_lines
		end

		it "does not record any priority 3 lines if there are any of priority 2" do
			produce_one_(:priority_2?)
			allow(joshua).to receive(:priority_1?).exactly(8).times.and_return(false)
			expect(joshua).not_to receive(:priority_3?)
			joshua.prioritise_lines
		end

		it "otherwise records a priority 3 line if there is one" do
			no_priority_ones
			no_priority_twos
			expect(joshua).to receive(:priority_3?).exactly(8).times.and_return(*one_positive)
			joshua.prioritise_lines
			expect(joshua.candidate_lines.length).to eq 1
			expect(joshua.candidate_lines).to include(joshua.board.row(1))
		end

		it "otherwise records multiple priority 3 lines if there are any" do
			no_priority_ones
			no_priority_twos
			expect(joshua).to receive(:priority_3?).exactly(8).times.and_return(*three_positives)
			joshua.prioritise_lines
			check_lines_registered
		end

	end

	context "choosing among candidate lines" do

		it "chooses among equal priority 1 lines by the one which contains its mark(s)" do
			line1 = double :line, marked_by?: false
			line2 = double :line, marked_by?: true
			allow(joshua).to receive(:priority_1?).and_return(true)
			expect(joshua).to receive(:candidate_lines).and_return([line1, line2])
			expect(joshua.tiebreak_lines).to eq line2
		end

		it "if no priority 1 lines, returns all priority 2 lines marked by itself" do
			line1 = double :line, marked_by?: true
			line2 = double :line, marked_by?: true
			allow(joshua).to receive(:priority_1?).and_return(false)
			expect(joshua).to receive(:candidate_lines).twice.and_return([line1, line2])
			expect(joshua.tiebreak_lines).to eq [line1, line2]
		end

		xit "plays on the empty square from a priority 1 line, picking the one it dominates as a tiebreak" do
			no_priority_twos
			produce_one_(:priority_1?)
			expect(joshua).to receive(:pick_candidates).with(:row).and_return([:square])
			expect(joshua).to receive(:prioritise_from)#.with(:rows).and_return(:row)
			expect(joshua).to receive(:prioritise_lines)
		end

	end

end