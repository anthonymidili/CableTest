module MessagesHelper
  def message_author?(message, current_user)
    "author" if message.user == current_user
  end

  def message_background(message, current_user)
    if message.user == current_user
      "author"
    else
      "background_#{message.user.last_digit}"
    end
  end
end
