module MessagesHelper
  def message_author(message, current_user)
    "author" if message.user == current_user
  end
end
