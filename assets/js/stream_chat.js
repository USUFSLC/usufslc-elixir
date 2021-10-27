let StreamChat = {
  init(socket) {
    let channel = socket.channel('stream_chat:lobby')
    channel.join()
    this.listenForChats(channel)
  },
  addMessage(user, message) {
    let body = `<span class="username"><b>${user}</b></span>: ${message}<br>`
    if (message.match(new RegExp(`@${window.userName}`, "ig"))) {
      $("#chat-box").append('<p class="chat-entry"><span class="mentioned">' + body + '</span></p>')
    } else {
      $("#chat-box").append('<p class="chat-entry">' + body + '</p>')
    }
  },
  scrollBottom() {
    $("#chat-box").animate({ scrollTop: $('#chat-box').prop("scrollHeight")}, 200)
  },
  listenForChats(channel) {
    $(() => {
      $("#chat-form").on("submit", function(ev) {
        ev.preventDefault()

        let userMsg = $('#user-msg').val()
        channel.push('send', {body: userMsg})

        $("#user-msg").val("")
      })

      channel.on('shout', function(payload) { 
        StreamChat.addMessage(payload.name, payload.body)
        StreamChat.scrollBottom()
      })
    })
  }
}

export default StreamChat;
