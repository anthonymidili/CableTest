class SendMessageJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3

  def perform(user, message, room)

    RoomChannel.broadcast_to user,
    message_partial: render_message(message),
    message_id: message.id,
    room_id: room.id
  end

  private

  def render_message(message)
    MessagesController.render partial: 'messages/message',
    locals: { message: message, current_user: nil }
  end
end
