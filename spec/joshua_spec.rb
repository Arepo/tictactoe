require 'joshua'

class JoshuaTest; include Joshua; end

describe Joshua do

	before do
		Singleton.__init__(Board)
	end

	let(:joshua) {JoshuaTest.new}
	let(:square0) {double :square, mark: nil}
	let(:square1) {double :square, mark: :x}
	let(:square2) {double :square, mark: :o}
	

	xit "specifies the row and square it's going to play on" do
		expect(joshua.determine_square.class).to eq Array
	end

	# xit "sees if row 1 contains two identical marks" do
	# 	mark = nil
	# 	joshua.board.row(1).each {|square| square.mark_with(Mark.new(mark)); mark = :X }
	# 	expect(joshua.)
	# 	# expect(joshua).to receive(:add_candidate).with(joshua.board.row(1).square(1))
	# 	joshua.check_rows
	# end

	# xit "sees if row 3 contains two identical marks" do
	# 	mark = nil
	# 	joshua.board.row(3).each {|square| square.mark_with(Mark.new(mark)); mark = :X }
	# 	# expect(joshua).to receive(:add_candidate).with(joshua.board.row(3).square(1))
	# 	joshua.check_rows
	# end

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

	it "can look at the board's rows" do
		expect(joshua.rows).to eq(joshua.board.rows)
	end

	it "can look at the board's diagonals" do
		expect(joshua.diagonals).to eq(joshua.board.diagonals)
	end

	it "can look at the board's columns" do
		expect(joshua.columns).to eq(joshua.board.columns)
	end

	it "looks through all the lines, and doesn't record any as priority 1 if none are." do
		expect(joshua).to receive(:priority_1?).exactly(8).times.and_return(false)
		joshua.pick_lines
		expect(joshua.priority_1_lines.length).to eq 0
	end

	it "looks through all the lines and records (the) one if one priority 1" do
		allow(joshua).to receive(:priority_1?).exactly(8).times.and_return(true, false, 
		false, false, false, false, false, false)
		joshua.pick_lines
		expect(joshua.priority_1_lines.length).to eq 1
		expect(joshua.priority_1_lines).to include(joshua.board.row(1))
	end

	it "looks through all the lines and records each one if one priority 1" do
		allow(joshua).to receive(:priority_1?).exactly(8).times.and_return(false, true, 
		false, false, true, false, true, false)
		joshua.pick_lines
		expect(joshua.priority_1_lines.length).to eq 3
		expect(joshua.priority_1_lines).to include(joshua.board.row(2))
		expect(joshua.priority_1_lines).to include(joshua.board.column(2))
		expect(joshua.priority_1_lines).to include(joshua.board.diagonals.first)
	end

end