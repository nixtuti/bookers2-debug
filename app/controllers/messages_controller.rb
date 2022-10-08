class MessagesController < ApplicationController
  
  def create
    @message = current_user.messages.new(message_params)
    @message.save
    redirect_to room_path(@message.room_id)
  end
  
  private

  def message_params 
    params.require(:message).permit(:message,:user_id, :room_id).merge(user_id: current_user.id)
  end

end
