module RoomsHelper
  def room_creator?(room)
    room.user == current_user
  end
end
