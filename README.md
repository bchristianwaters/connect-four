# README

To work on this app start by forking, pulling down, or cloning it.
Afterword, run "bundle install" and the "rails db:migrate".
Then you can run the application and it should like the following:

![Board](/lib/assets/board.png?raw=true "Board")

This is a connect four app. Currently, this app is best played on one computer.

There is a Game model that stores relevant information about each game such as
whose turn it is, how many moves have been made, the status of the game, and the 
layout of the board. The model can also check to see if anyone has won and place
down board pieces.

The games controller has methods for creating a new game, placing down a board
piece, and displaying a game.

The game is displayed in the games show page. In addition to the board, the show
page displays information about the status of the game, whose turn it is, and 
a button to start a new game. The buttons for placing down pieces change colors 
to indicate whose turn it is. 
