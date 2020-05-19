class SendMessageJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3

  def perform(user, message, room)
    RoomChannel.broadcast_to user,
    email: message.user.email,
    content: message.content,
    room_id: room.id
  end
end
