require 'joshua'

class JoshuaTest; include Joshua; end

describe Joshua do

	before do
		Singleton.__init__(Board)
	end

	let(:joshua) {JoshuaTest.new}

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

	it "can tell if a set of three squares have exactly two that == each other" do
		expect(joshua.priority_1?(:square1, :square1, :square2)).to eq true
		expect(joshua.priority_1?(:square2, :square2, :square2)).to be_falsy
		expect(joshua.priority_1?(:square1, :square2, :square3)).to be_falsy
	end

	xit "picks a square from three that doesn't match the other two" do
		expect(joshua.pick_candidate(:square1, :square1, :square2)).to eq :square2
		expect(joshua.pick_candidate(:square1, :square2, :square2)).to eq :square1
		expect(joshua.pick_candidate(:square2, :square2, :square2)).to eq nil
		expect(joshua.pick_candidate(:square1, :square2, :square3)).to eq nil
	end

end