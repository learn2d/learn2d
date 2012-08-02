define ->
  class Level
    constructor: ({@loader, levelName}) ->
      @name = levelName

    getName: ->
      return @name

    getLevelData: ->
      @loader.loadLevel @name

    onWall: (x, y, width = 0, height = 0) ->
      levelData = @getLevelData()
      return false unless levelData

      tileWidth = levelData.tilewidth
      tileHeight = levelData.tileheight

      # outside of level is a wall
      return true if x > levelData.width * tileWidth
      return true if x < 0
      return true if y > levelData.height * tileHeight
      return true if y < 0

      boardX = x / tileWidth
      boardY = y / tileHeight

      for dx in [0...width] by 1
        for dy in [0...height] by 1
          boardCheckX = Math.floor(boardX + (dx / tileWidth))
          boardCheckY = Math.floor(boardY + (dy / tileHeight))
          tileIndex = boardCheckY * levelData.width + boardCheckX
          return true if levelData.collisionData[tileIndex]

      false