require_relative 'spec_helper'

class CheckerContainer; include WinChecker; end

describe WinChecker do

	def fill_row(row_num)
		winchecker.board.row(row_num).each {|square| square.mark_with(Mark.new(:player1)) }
	end

	def fill_column(column_num)
		winchecker.board.column(column_num).each {|square| square.mark_with(Mark.new(:player1)) }
	end

	let(:winchecker) {CheckerContainer.new}

	before do
    	Singleton.__init__(Board)
  	end

	it 'can recognise when three squares bear the same mark' do
		matching_squares = Array.new(3) {Square.new.mark_with(:X) }
		expect(winchecker.equivalent_squares_in?(matching_squares)).to be true
	end

	it "can recognise when they don't bear the same mark" do
		unmatching_squares = Array.new(3) {Square.new}
		expect(winchecker.equivalent_squares_in?(unmatching_squares)).to be_falsy
	end

	it "can check that there aren't three consecutive marks in any row" do
		expect(winchecker.completed_row?).to be_falsy
	end

	it "can see when there are three consecutive marks in row 1" do
		fill_row(1)
		expect(winchecker.completed_row?).to be true
	end
	
	it "can see when there are three consecutive marks in row 3" do
		fill_row(3)
		expect(winchecker.completed_row?).to be true
	end

	it "can see when no column has three consective marks" do
		expect(winchecker.completed_column?).to be_falsy
	end

	it "can see when there are three consecutive marks in column 1" do
		fill_column(1)
		expect(winchecker.completed_column?).to be true
	end

	it "can see when there are three consecutive marks in column 3" do
		fill_column(3)
		expect(winchecker.completed_column?).to be true
	end

	it "can see when neither diagonal has three consecutive marks" do
		expect(winchecker.completed_diagonal?).to be_falsy
	end

	it "can see when t/l to b/r diagonal has three consecutive identical marks" do
		mark = Mark.new(:me)
		winchecker.board.row(1).square(1).mark_with mark
		winchecker.board.row(2).square(2).mark_with mark
		winchecker.board.row(3).square(3).mark_with mark
		expect(winchecker.completed_diagonal?).to be true
	end

	it "can see when t/r to b/l diagonal has three consecutive identical marks" do
		mark = Mark.new(:me)
		winchecker.board.row(1).square(3).mark_with mark
		winchecker.board.row(2).square(2).mark_with mark
		winchecker.board.row(3).square(1).mark_with mark
		expect(winchecker.completed_diagonal?).to be true
	end

	it "can check all orientations at once" do
		expect(winchecker).to receive(:completed_row?)
		expect(winchecker).to receive(:completed_column?)
		expect(winchecker).to receive(:completed_diagonal?)
		winchecker.completed_line?
	end

	it "can tell if any line has been completed" do
		allow(winchecker).to receive(:completed_row?).and_return(true, false, false)
		expect(winchecker.completed_line?).to be true
		allow(winchecker).to receive(:completed_column?).and_return(true, false)
		expect(winchecker.completed_line?).to be true
		allow(winchecker).to receive(:completed_diagonal?).and_return(true)
		expect(winchecker.completed_line?).to be true
	end

	it "can tell if no line has been completed" do
		expect(winchecker.completed_line?).to be_falsy
	end

	it "can tell if all squares are full" do
		(1..3).each {|num| fill_row(num)}
		expect(winchecker.board_full?).to be true
	end

end