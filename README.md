Unbeatable TicTacToe
=========

This is a 0-2 player version of TicTacToe, playable only in the console via keyboard commands. The goal I gave myself was to create a thoroughly RSpec tested game as a learning exercise, using nothing besides basic ruby - no gems except for testing. And the AI had to be unbeatable.

I didn't worry about the UI too much (let's politely call it ugly but forgiving), but I was trying to write code as clearly as possible, in such a way as to make it relatively easy to extend for play on an N*N grid. I think it would be easy to do so for the two-player game. Joshua (the AI) would need a little tweaking, but probably not too much for him to play sanely if imperfectly.

Setting up the Game
---------

You'll need at least Ruby 1.9 installed, since it uses the new hash syntax. I'm using 2.1.2, so intermediate versions might have compatibility errors.

Clone the code into your chosen directory, navigate to the directory, and type './tictactoe.rb' into the terminal to begin.

You'll be prompted for the number of human players - there will always be two players, with Joshua controlling any that humans don't. In a one-player game, the human always plays first.

The Rules of TicTacToe
---------
