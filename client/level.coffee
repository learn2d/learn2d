define ->
  class Level
    constructor: ({@loader, levelName}) ->
      @name = levelName

    getName: ->
      return @name

    getLevelData: ->
      @loader.loadLevel @name

    onWall: (x, y, width, height) ->
      return false