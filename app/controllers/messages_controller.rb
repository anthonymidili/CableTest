class MessagesController < ApplicationController
  before_action :set_room

  def new
    @message = @room.messages.new
  end

  def create
    @message = @room.messages.create(msg_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        # broadcast to other users.
        broadcast_to_other_users

        format.html { redirect_to @room }
        # display message current user broadcasted to all other users
        format.js
      else
        format.html { render @room }
      end
    end
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  # this can be placed inside an active job
  def broadcast_to_other_users
    users = User.other_users(current_user)

    users.each do |user|
      RoomChannel.broadcast_to user,
      email: @message.user.email,
      content: @message.content,
      room_id: @room.id
    end
  end
end
