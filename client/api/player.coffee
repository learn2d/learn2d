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
      @sceneGraph.getPlayer().x

    setX: (x) ->
      @sceneGraph.getPlayer().x = x

    getY: ->
      @sceneGraph.getPlayer().y

    setY: (y) ->
      @sceneGraph.getPlayer().y = y