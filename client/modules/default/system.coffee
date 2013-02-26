define ->
  class System extends PlayerModule
    onMouseDown: (mouse) ->
      @trigger.send
        target: 'system'
        action: 'createPlayer'
        params:
          x: mouse.x
          y: mouse.y
