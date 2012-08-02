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

      Object.defineProperty this, 'direction',
        get: @getDirection
        set: @setDirection
        enumerable: true
        configurable: false

      Object.defineProperty this, 'width',
        get: ->
          24
        enumerable: true
        configurable: false

      Object.defineProperty this, 'height',
        get: ->
          24
        set: @setDirection
        configurable: false

    getX: ->
      @sceneGraph.getPlayer().getX()

    setX: (x) ->
      @sceneGraph.getPlayer().setX(x)

    getY: ->
      @sceneGraph.getPlayer().getY()

    setY: (y) ->
      @sceneGraph.getPlayer().setY(y)

    getDirection: ->
      @sceneGraph.getPlayer().getDirection()

    setDirection: (direction) ->
      @sceneGraph.getPlayer().setDirection(direction)

    getAni: ->
      @sceneGraph.getPlayer().getAniName()

    setAni: (aniName) ->
      @sceneGraph.getPlayer().setAniName(aniName)
