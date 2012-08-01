define ->
  class Player
    constructor: (@sceneGraph) ->
      Object.defineProperty this, 'x',
        get: @getX
        set: @setX
        enumerable: true
        configurable: false

      Object.defineProperty this, 'y',
        get: @getY
        set: @setY
        enumerable: true
        configurable: false

    getX: ->
      @sceneGraph.getPlayer().getX()

    setX: (x) ->
      @sceneGraph.getPlayer().setX(x)

    getY: ->
      @sceneGraph.getPlayer().getY()

    setY: (y) ->
      @sceneGraph.getPlayer().setY(y)