define ->
  class Viewport
    constructor: (@context) ->

    setPlayer: (@player) ->

    setLevel: (@level) ->

    offsetX: ->
      viewportWidth = @_getViewportWidth()
      playerX = @player.getX()
      offsetX = -1 * playerX + (viewportWidth / 2)

      if offsetX > 0
        offsetX = 0

      levelData = @level.getLevelData()
      levelWidth = levelData.width * levelData.tilewidth

      if offsetX + levelWidth < viewportWidth
        offsetX = viewportWidth - levelWidth

      return offsetX

    offsetY: ->
      viewportHeight = @_getViewportHeight()
      playerY = @player.getY()
      offsetY = -1 * playerY + (viewportHeight / 2)

      if offsetY > 0
        offsetY = 0

      levelData = @level.getLevelData()
      levelHeight = levelData.height * levelData.tileheight

      if offsetY + levelHeight < viewportHeight
        offsetY = viewportHeight - levelHeight

      return offsetY

    _getViewportWidth: ->
      @context.canvas.width

    _getViewportHeight: ->
      @context.canvas.height