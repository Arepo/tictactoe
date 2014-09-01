require 'joshua'

class JoshuaTest; include Joshua; end

describe Joshua do

	before do
		Singleton.__init__(Board)
	end

	let(:joshua) {JoshuaTest.new}
	let(:mark0) {double :mark, mark: nil}
	let(:mark1) {double :mark, mark: :x}
	let(:mark2) {double :mark, mark: :o}
	

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

	it "can tell if a set of three squares has exactly two that == each other, and considers it top priority" do
		expect(joshua.priority_1?(mark1, mark1, mark2)).to eq true
		expect(joshua.priority_1?(mark1, mark2, mark0)).to be_falsy
		expect(joshua.priority_1?(mark1, mark1, mark1)).to be_falsy
		expect(joshua.priority_1?(mark0, mark0, mark0)).to be_falsy
	end

	it "can tell if a set of three squares has exactly 1 square marked, and considers it second priority" do
		expect(joshua.priority_2?(mark1, mark0, mark0)).to eq true
		expect(joshua.priority_2?(mark1, mark1, mark0)).to be_falsy
		expect(joshua.priority_2?(mark1, mark2, mark0)).to be_falsy
		expect(joshua.priority_2?(mark0, mark0, mark0)).to be_falsy
	end

	xit "picks a square from three that doesn't match the other two" do
		expect(joshua.pick_candidate(mark1, mark1, mark2)).to eq mark2
		expect(joshua.pick_candidate(mark2, mark2, mark1)).to eq mark1
		expect(joshua.pick_candidate(mark2, mark2, mark2)).to eq nil
		expect(joshua.pick_candidate(mark1, mark2, mark0)).to eq nil
	end

end