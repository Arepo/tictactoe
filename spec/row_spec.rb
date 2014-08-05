require 'row.rb'

describe Row do

	let(:game){Game.instance}

	it 'can refer to each square ' do
		expect(game.row(1).first_square).to eq game.row(1)[0]
		expect(game.row(1).second_square).to eq game.row(1)[1]
		expect(game.row(1).third_square).to eq game.row(1)[2]
		expect(game.row(1).square(3)).to eq (game.row(1).third_square)
		expect(game.row(1).square(1)).to eq (game.row(1).first_square)
	end

end