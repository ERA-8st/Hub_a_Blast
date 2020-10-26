$ ->
  App.room = App.cable.subscriptions.create "RoomChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    # received: (data) ->
    #   alert data['room_id']

    received: (data) ->
      # alert data['room_id']
      $('.label').append(data['message'])

    speak: (message, user_id, room_id) ->
      @perform 'speak', message: message, user_id: user_id, room_id: room_id

    $(document).on 'keypress', '[data-behavior-message~=room_speaker]', (event) ->
      if event.keyCode is 13 # return = send
        App.room.speak(event.target.value, event.target.dataset.user_id, event.target.dataset.room_id)
        event.target.value = ''
        event.preventDefault()