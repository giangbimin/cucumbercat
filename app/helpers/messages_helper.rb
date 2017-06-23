module MessagesHelper
  def left_or_right(message)
    message.user == current_user ? "right" : "left"
  end

  def media_or_right(message)
    message.user == current_user ? "right" : "media"
  end
end
