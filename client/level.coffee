define ->
  class Level
    constructor: ({@loader, levelName}) ->
      @name = levelName

    getName: ->
      return @name

    getLevelData: ->
      @loader.loadLevel @name