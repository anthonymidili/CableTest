import consumer from "./consumer"

$(document).on('turbolinks:load', function() {
  consumer.subscriptions.create("OccupancyChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel

      // Update active users count.
      $("#active_users_count_room_" + data.room_id).html(data.user_count);
    }
  });
});
