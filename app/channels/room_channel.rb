class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    room = Room.find(params[:room])

    current_user.room = room
    current_user.save

    stream_for room
  end

  def unsubscribed
    current_user.room = nil
    current_user.save

    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
