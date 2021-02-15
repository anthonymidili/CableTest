import consumer from "./consumer"

import audioUrl from "../audio/just-saying-593.mp3";
var sound = new Audio(audioUrl);

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel

    // Only do if in the corect room.
    if ($("#msg_room_" + data.room_id).length) {
      // Prepend messages/message partial
      $("#msg_room_" + data.room_id).prepend(data.message_partial);
      // Add "new_message" class.
      $('#message_' + data.message_id).addClass('new_message');
      // Play audio.
      sound.play();
    }
  }
});
