$ ->
  App.room = App.cable.subscriptions.create "RoomChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # DM
      user_id = $('.user_id').val()
      room_id = $('.room_id').val()
      chat_content = $(document.createElement("p")).append( data['message'].message + "<br>" + data['created_at'] )
      if String(data['message'].room_id) == room_id
        if user_id == String(data['message'].user_id)
          $(".chat").append($(document.createElement("div")).addClass("right-chat-box").append(chat_content))
        else
          user_img = $(document.createElement("img")).attr({'src': $("#pair_user_img").get(0).src, 'width': "40", 'height': "40"})
          $(".chat").append($(document.createElement("div")).addClass("left-chat-box").append($(document.createElement("div")).addClass("chat-image").append( user_img )).append($(document.createElement("div")).addClass("chat-message").append( chat_content )))
      # Notification
      if String(data['pair_user_id']) == $('.user_header_notification').val()
        if $('.notice-count').length
          new_notice_count = Number($('.notice-count').text()) + 1
          $('.notice-count').text(String(new_notice_count))
        else
          $('.user-notice').append($(document.createElement("p")).addClass('notice-count').append(1))

    speak: (message, user_id, room_id) ->
      @perform 'speak', message: message, user_id: user_id, room_id: room_id

    $(document).on 'keypress', '[data-behavior-message~=room_speaker]', (event) ->
      if event.keyCode is 13 # return = send
        App.room.speak(event.target.value, event.target.dataset.user_id, event.target.dataset.room_id)
        event.target.value = ''
        event.preventDefault()