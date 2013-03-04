define ->
  class Player
    constructor: (@sceneGraph, @network) ->
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

    getHealth: ->
      @sceneGraph.getPlayer().getHealth()

    setHealth: (deltaHealth) ->
      @sceneGraph.getPlayer().setHealth(deltaHealth)

    ###
    Set a variable on the player object. Based on the prefix, this variable
    will be shared with other players and/or the server.
    ###
    set: (key, value) ->
      [keyPrefix, keySuffix] = key.split('.')
      switch keyPrefix
        when 'public'
          @network.playerDataUpdates[key] = value
          # update scene graph with new public variable
          console.log 'update scene graph with new var'
          console.log keyPrefix
          console.log keySuffix
          console.log value
      return
