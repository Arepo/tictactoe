#!/usr/bin/env ruby
require_relative './lib/game'

game = Game.new
while true
	game.run_game
end