import consumer from "./consumer"

var audioUrl = new Audio("https://notificationsounds.com/soundfiles/acc3e0404646c57502b480dc052c4fe1/file-sounds-1140-just-saying.mp3");

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    $("#msg_room_" + data.room_id).prepend(
      '<div class="message callout alert">' +
      data.email +
      " wrote: " +
      data.content +
      '</div>'
    )

    // SIMPLE EXEMPLE
    audioUrl.play();
  }
});
