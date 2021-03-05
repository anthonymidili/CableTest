module MessagesHelper
  def message_author?(message)
    message.user == current_user
  end

  def message_background(message)
    if message.user == current_user
      "author"
    else
      "background_#{message.user.last_digit}"
    end
  end
end
