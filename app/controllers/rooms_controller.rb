class RoomsController < ApplicationController
  
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = Message.new
  end
  
  def create
    @room = Room.create
    Entry.create(room_id: @room.id, user_id: current_user.id)
    Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

end
