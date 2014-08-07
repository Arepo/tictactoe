require 'game'

class CheckerContainer; include WinChecker; end

describe WinChecker do

	let(:winchecker) {CheckerContainer.new}

	before do
    	Singleton.__init__(Board)
  	end

	it 'can recognise when three squares bear the same mark' do
		matching_squares = Array.new(3) {Square.new.mark = :X}
		expect(winchecker.equivalent_squares_in?(matching_squares)).to be true
	end

	it "can recognise when they don't bear the same mark" do
		unmatching_squares = Array.new(3) {Square.new}
		expect(winchecker.equivalent_squares_in?(unmatching_squares)).to be_falsy
	end

	it "can check that there aren't three consecutive marks in a row" do
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

	it "can see when t/l to b/r diagonal has three consecutive marks" do
		winchecker.board.row(1).square(1).mark = :O
		winchecker.board.row(2).square(2).mark = :O
		winchecker.board.row(3).square(3).mark = :O
		expect(winchecker.completed_diagonal?).to be true
	end

	it "can see when t/r to b/l diagonal has three consecutive marks" do
		winchecker.board.row(1).square(3).mark = :O
		winchecker.board.row(2).square(2).mark = :O
		winchecker.board.row(3).square(1).mark = :O
		# winchecker.player2.play_on(winchecker.board.row(2).square(2))
		# winchecker.player2.play_on(winchecker.board.row(3).square(1))
		expect(winchecker.completed_diagonal?).to be true
	end

	def fill_row(row_num)
		winchecker.board.row(row_num).each {|square| square.mark = :O }
	end

	def fill_column(column_num)
		winchecker.board.column(column_num).each {|square| square.mark = :O }
	end

end