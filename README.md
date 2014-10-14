Unbeatable TicTacToe
=========

[![Build Status](https://travis-ci.org/Arepo/tictactoe.svg?branch=master)](https://travis-ci.org/Arepo/tictactoe)
[![Coverage Status](https://coveralls.io/repos/Arepo/tictactoe/badge.png?branch=master)](https://coveralls.io/r/Arepo/tictactoe?branch=master)

This is a 0-2 player version of TicTacToe, playable only in the console via keyboard commands. The goal I gave myself was to create a thoroughly RSpec tested game as a learning exercise, using nothing besides basic ruby - no gems except for testing. And the AI had to be unbeatable.

I didn't worry about the UI too much (let's politely call it ugly but forgiving), but I was trying to write code as clearly as possible, in such a way as to make it relatively easy to extend for play on an NxN grid. I think it would be easy to do so for the two-player game. Joshua (the AI) would need a little tweaking, but probably not too much for him to play sanely if imperfectly.

Setting up the Game
---------

You'll need at least Ruby 1.9 installed, since it uses the new hash syntax. I'm using 2.1.2, so intermediate versions might have compatibility errors.

Clone the code into your chosen directory, navigate to the directory, and type './tictactoe.rb' into the terminal to begin.

You'll be prompted for the number of human players - there will always be two players, with Joshua controlling any that humans don't. In a one-human game, the human always plays first.

The Rules of TicTacToe
---------

Really? Ok, fine...

Each player takes it in turn to mark any square on a 3x3 grid, one with an X, the other with an O. 

In this version, human players will be prompted to enter coordinates one at a time, starting with the row number (ascending top-bottom), then column number (ascending left-right)

The winner is the first player to fill a line (horizontally, vertically or diagonally) with their mark. If the board is filled with neither player having completed a line, the game is a draw.

Given perfect play, the game will always be a draw. If you play it more than twice, you should probably reexamine your life.

Future Improvements/Lessons
------

I think this is 'good enough' for now, given that I don't actually plan to expand the program. That said, there are some definite flaws (\*cough\* I mean learning experiences),  in retrospect:

 * High level testing was a mess, with too many metamethod tests that checked for and/or had to allow for precise method call sequences. In retrospect a better solution would probably have been not to use so many stubs and mocks for the higher level tests, but perhaps to separate them into a different spec file and check that when I ran the method, the status of real instances of the objects changed as I expected. I'm currently reading through Sandi Metz's Practical Object-Oriented Design in Ruby, which has an impending chapter that sounds relevant.
 * Some methods were still too bulky. If I ever expected to extend the program, they'd be the first things I'd want to improve, but for what it is, I left them once they felt good enough.
 * The joshua module seems worryingly long. I'm not really sure if this is actually a problem. It only has one responsibility in the sense of 'not losing the game', but conceptually this could obviously be broken down further.
 * Joshua himself is a heavy compromise on the NxN extensibility. I had to spike a bit to get him to work at all, so while I hope his algorithms wouldn't be too difficult to modify, they certainly wouldn't get far as they are.
 * I felt a bit dirty monkeypatching the Array class rather than creating one that inherited from it, but it was the simplest way I could think of to allow transposed rows to still behave like normal rows. Again, I'm not sure yet if this is bad practice in such a case.
 * I accidentally cheated at one problem - getting an array of the most common elements in an array. When Googling to find if Ruby existing options that would help, I found a page that just wrote out a solution far more elegant than I would have come up with, but having seen it it was etched into my brain. I'd like to return to that problem in a month or two, having hopefully forgotten the solution, to see if I come up with something as good, or almost as good unassisted.
 * I think there's too much interweaving of classes. I tried to keep it to a minimum, but if I were to redo the whole thing, I'd be more comfortable with a clearer hierarchy of class tasks.
 * They're (hopefully) not visible in the final version, but I wrote a number of methods and tests for methods that never ended up in use. To avoid this, or at least reduce it if I were starting again, I'd write down in clear English at least the algorithm I expected the AI to use, ie the algorithm to always win or draw; I'd also try to focus more on each part of the program until I'd linked it to the top level (or at least a higher level) operation. The latter feels emotionally less satisfying, since sometimes switching track can be a relief, but would prob result in fewer overlapping functions.
