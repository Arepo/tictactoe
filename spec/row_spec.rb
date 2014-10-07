require_relative 'spec_helper'

describe 'row' do

	context 'is a monkeypatched array with a couple of extra methods:' do

		let(:board){Board.instance}

		it 'it can refer to each square ' do
			expect(board.row(1).square(3).class).to be Square
			expect(board.row(1).square(1).class).to be Square
		end

		it "it can check whether any of its squares are marked by a specified player" do
			p1mark = double :mark, source: :player1
			expect(board.row(1).marked_by?(:player1)).to be_falsy
			board.row(1).square(1).mark_with(p1mark)
			expect(board.row(1).marked_by?(:player1)).to be true
		end	

		it "can pick out an array of its modal elements" do
			expect(%w{square1 square1 square2 square2 square3}.get_mode). to eq ["square1", "square2"]
		end

	end

end