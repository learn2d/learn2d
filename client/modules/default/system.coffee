define ->
  class System
    constructor: ({@trigger}) ->
    onMouseDown: (mouse) ->
      @trigger.send
        target: 'server/modules/system'
        action: 'createPlayer'
        params:
          x: mouse.x
          y: mouse.y