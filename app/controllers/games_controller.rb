class GamesController < ApplicationController
  #creates a new game
  def new
     @game = Game.new
     @users = User.all
  end
  
  def create
    @game = Game.new
    begin
      p2 = params[:game][:p2]
      if p2.include?("@")
        @game.p2 = User.find_by(email: p2).id
      elsif p2
        @game.p2 = p2
      end
    rescue
      @game.p2 = current_user.id
    end
    @game.board = "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    @game.turn = "red"
    @game.moves = 0
    @game.state = "In progress"
    @game.p1 = current_user.id
    @game.game_type = params[:game_type]
    if @game.save
      redirect_to @game
    else
      render :new
    end 
  end
  
  #places a piece and updates the board
  def place
    @game = Game.find(params[:game])
    @column = params[:column]
    @turn = @game.turn
    @height = @game.height(@column.to_i)
    @state = @game.state
    @game.place(@column.to_i)
    if @game.game_type == "easy"
      @game.easy()
    elsif @game.game_type == "medium"
      @game.medium()
    elsif @game.game_type == "difficult"
      @game.difficult()
    end
    ActionCable.server.broadcast 'games',
      type: "game",
      game_id: @game.id,
      height: @height
    redirect_to game_path(@game.id, params: {height: @height})
  end
  
  #displays the game
  def show
    @game = Game.find(params[:id])
  end
  
  private 
  def game_params
    params.require(:game).permit(:p2)
  end
end
