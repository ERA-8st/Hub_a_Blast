App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    alert data['id']

  # received: (data) ->
  #   $('#messages').append data['message']

  speak: (message, id) ->
    @perform 'speak', message: message, id: id

  $ ->
    $(document).on 'keypress', '[data-behavior-message~=room_speaker]', "[data-behavior-id~=room_id]", (event) ->
      if event.keyCode is 13 # return = send
        App.room.speak(event.target.value, 1)
        event.target.value = ''
        event.preventDefault()