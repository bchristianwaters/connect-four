class MessagesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    message = @game.messages.new(message_params)
    message.user = current_user
    if message.save
      redirect_to @game
    else
      redirect_to @game
    end
    
  end

   private
   def message_params
     params.require(:message).permit(:content)
   end
end
