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
        ActionCable.server.broadcast "room_channel",
        email: @message.user.email,
        content: @message.content,
        room_id: @room.id

        format.html { redirect_to @room }
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
end
