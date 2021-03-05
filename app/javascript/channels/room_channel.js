import consumer from "./consumer"

import audioUrl from "../audio/just-saying-593.mp3";

$(document).on('turbolinks:load', function() {
  var sound = new Audio(audioUrl);
  var room_id = $('[id^=room_id_]').data("room-id");
  var current_user_id = $('[id^=room_id_]').data("current-user-id");

  consumer.subscriptions.create({channel: "RoomChannel", room: room_id}, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel

      // Only do if in the not the current_user.
      if (data.sender_id != current_user_id) {
        // Prepend messages/message partial
        $("#msg_room_" + data.room_id).prepend(data.message_partial);
        // Add "new_message" class.
        $('#message_' + data.message_id).addClass('new_message');
        // Play audio.
        sound.play();
      }
    }
  });
});
