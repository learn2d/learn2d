define ->
  class Level
    constructor: (@sceneGraph) ->
      Object.defineProperty this, 'name',
        get: @getName
        enumerable: true
        configurable: false

    getName: ->
      @sceneGraph.getPlayerLevel().getName()

    onWall: (x, y, width, height) ->
      return false