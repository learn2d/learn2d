define ->
  class Level
    constructor: ({@loader, levelName}) ->
      @name = levelName
      console.log "name: #{@name}"

    getName: ->
      return @name

    getLevelData: ->
      @loader.loadLevel @name