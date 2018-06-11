class MessagesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    message = @game.messages.new(message_params)
    message.user = current_user
    if message.save
      ActionCable.server.broadcast 'games',
        type: "message",
        user: message.user.first_name + " " + message.user.last_name,
        content: message.content
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
