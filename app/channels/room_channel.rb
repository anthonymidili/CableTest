class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    room = Room.find(params[:room])

    current_user.room = room
    current_user.save

    ActionCable.server.broadcast("room_occupancy", {
      room_id: room.id,
      user_count: room.users.count
    })

    stream_for room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    room = current_user.room

    current_user.room = nil
    current_user.save

    ActionCable.server.broadcast("room_occupancy", {
      room_id: room.try(:id),
      user_count: room.try(:users).try(:count)
    })

    stop_all_streams
  end
end
