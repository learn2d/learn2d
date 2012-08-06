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
      
    collisionCheck: (x, y) ->
      levelData = @getLevelData()
      return false unless levelData
      
      if x > 0 -16 and x < 1024 - 24 and y > 0 and y < 1024

        tileWidth = levelData.tilewidth
        tileHeight = levelData.tileheight
        
        xpos = Math.floor((x - 8)/tileWidth) + 1
        yposB = Math.floor((y - 2)/tileHeight) + 1
        yposT = Math.floor((y - 19)/tileHeight) + 1

        Colls = levelData.collisionData

        if Colls[xpos + yposB*32]? or Colls[xpos + yposT*32]?
          tileTop = Colls[xpos + yposT*32]
          tileBot = Colls[xpos + yposB*32]
        
        if tileBot or tileTop
          return true
        else
          return false
        
      else
        return true
