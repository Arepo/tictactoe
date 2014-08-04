require 'player'

describe Player do 

	let(:malcolm){Player.new}
	let(:square) {Square.new}

	it 'can place its X mark on a square' do
		malcolm.play_on(square)
		expect(square === :X).to be_truthy
	end

	it 'can have O as its mark and play that on a square' do
		inara = Player.new(:O)
		inara.play_on(square)
		expect(square === :O).to be_truthy
	end

	it 'has a game' do
		expect(malcolm.game.class).to eq Game
	end
	
end