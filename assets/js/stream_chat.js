let StreamChat = {
  init(socket) {
    let channel = socket.channel('stream_chat:lobby')
    channel.join()
    this.listenForChats(channel)
 },

  listenForChats(channel) {
    $(() => {
      $("#chat-form").on("submit", function(ev) {
        ev.preventDefault();

        let userMsg = $('#user-msg').val()
        channel.push('send', {body: userMsg})

        $("#user-msg").val("");
      })

      channel.on('shout', payload => {
        let body = `<span class="username"><b>${payload.name}</b></span>: ${payload.body}<br>`;
        if (payload.body.match(new RegExp(`@${window.userName}`, "ig"))) {
          $("#chat-box").append('<p class="chat-entry"><span class="mentioned">' + body + '</span></p>');
        } else {
          $("#chat-box").append('<p class="chat-entry">' + body + '</p>');
        }
        $("#chat-box").animate({ scrollTop: $('#chat-box').prop("scrollHeight")}, 200);
      })
    });
  }
}

export default StreamChat;