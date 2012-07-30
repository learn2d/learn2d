define ->
  class Trigger
    constructor: (@network) ->
    send: ({target, action, params}) ->
      @network.socket.emit 'trigger',
        target: target
        action: action
        params: params