import consumer from "channels/consumer"

let id = localStorage.getItem('user_id')

consumer.subscriptions.create({channel: "OrdersChannel", user_id: id}, {
  connected() {
    console.log("order channel connected")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    let str = `<div id="notif" class="visible notice" data-controller="flashes" data-action="click->flashes#connect" >`+ data['message'] +`</div>`
    $("#flash #msg").append(str)
    $("#pending-orders").prepend(data['html'])
    // Called when there's incoming data on the websocket for this channel
  }
});
