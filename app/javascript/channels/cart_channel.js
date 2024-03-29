import consumer from "channels/consumer"

let id = localStorage.getItem('cart_id')

consumer.subscriptions.create({channel: "CartChannel", cart_id: id}, {
    connected() {
        // Called when the subscription is ready for use on the server
        console.log("cart connected")
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        // Called when there's incoming data on the websocket for this channel
        let str = `<div id="notif" class="visible ${data['type']}" data-controller="flashes" data-action="click->flashes#connect" >${data['message']}</div>`
        $("#flash #msg").append(str)
        let audio = new Audio('https://www.notificationsounds.com/storage/sounds/file-sounds-1150-pristine.mp3')
        audio.play()
    }
});
