class GamesController < ApplicationController
  #creates a new game
  def create
    @game = Game.create(board: "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", turn: "red", moves: 0, state: "In progress")
    redirect_to @game
  end
  
  #places a piece and updates the board
  def place
    @game = Game.find(params[:game])
    @column = params[:column]
    @game.place(@column.to_i)
    redirect_to @game
  end
  
  #displays the game
  def show
    @game = Game.find(params[:id])
  end
end
