class MessagesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    message = @game.messages.new(message_params)
    message.user = current_user
    @username = ""
    unless message.user.first_name.nil?
      @username += message.user.first_name
    end
    unless message.user.last_name.nil?
      @username += " " unless @username.length == 0
      @username += message.user.last_name
    end
    if message.save
      ActionCable.server.broadcast 'games',
        type: "message",
        user: @username,
        game_id: @game.id,
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
