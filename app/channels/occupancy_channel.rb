class OccupancyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_occupancy"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
