require 'game'

describe Game do 

	before do
    	Singleton.__init__(Board)
  	end

	let(:game){Game.new}

	it 'has two players' do
		expect(game.player1.class).to eq Player
		expect(game.player2.class).to eq Player
	end

	it 'the first of whom marks their squares with an X' do
		game.player1.play_on(game.player1.board.row(1).square(2))
		expect(game.player1.board.row(1).square(2)).to eq :X
	end

	it 'the second of whom marks their squares with an O' do
		game.player2.play_on(game.player2.board.row(1).square(2))
		expect(game.player2.board.row(1).square(2)).to eq :O
	end

	it 'can recognise when three squares bear the same mark' do
		matching_squares = Array.new(3) {Square.new.mark = :X}
		expect(game.equivalent_squares_in?(matching_squares)).to be true
	end

	it "can recognise when they don't bear the same mark" do
		unmatching_squares = Array.new(3) {Square.new}
		expect(game.equivalent_squares_in?(unmatching_squares)).to be_falsy
	end

	it "can check that there aren't three consecutive marks in a row" do
		expect(game.completed_row?).to be_falsy
	end

	it "can see when there are three consecutive marks in row 1" do
		fill_row(1)
		expect(game.completed_row?).to be true
	end
	
	it "can see when there are three consecutive marks in row 3" do
		fill_row(3)
		expect(game.completed_row?).to be true
	end

	it "can see when no column has three consective marks" do
		expect(game.completed_column?).to be_falsy
	end

	it "can see when there are three consecutive marks in column 1" do
		fill_column(1)
		expect(game.completed_column?).to be true
	end

	it "can see when there are three consecutive marks in column 3" do
		fill_column(3)
		expect(game.completed_column?).to be true
	end

	it "can see when neither diagonal has three consecutive marks" do
		expect(game.completed_diagonal?).to be_falsy
	end

	it "can see when t/l to b/r diagonal has three consecutive marks" do
		game.player2.play_on(game.board.row(1).square(1))
		game.player2.play_on(game.board.row(2).square(2))
		game.player2.play_on(game.board.row(3).square(3))
		expect(game.completed_diagonal?).to be true
	end

	it "can see when t/r to b/l diagonal has three consecutive marks" do
		game.player2.play_on(game.board.row(1).square(3))
		game.player2.play_on(game.board.row(2).square(2))
		game.player2.play_on(game.board.row(3).square(1))
		expect(game.completed_diagonal?).to be true
	end

	def fill_row(row_num)
		game.board.row(row_num).each {|square| square.mark = :O }
	end

	def fill_column(column_num)
		game.board.column(column_num).each {|square| square.mark = :O }
	end

end