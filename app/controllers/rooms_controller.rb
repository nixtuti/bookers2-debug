class RoomsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = Message.new
    @user = User.find(params[:id])
  end
  
  def create
    @room = Room.create
    Entry.create(room_id: @room.id, user_id: current_user.id)
    Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  private
  
  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end
  
end
