define ->
  class LevelRenderer
    constructor: (@loader, @context) ->

    draw: ->
      levelData = @loader.loadLevel 'test.level'
      return unless levelData

      @drawLayers levelData

    drawLayers: (levelData) ->
      for layer in levelData.layers
        @drawLayer levelData, layer

    drawLayer: (levelData, layer) ->
      horizontalTiles = levelData.width
      verticalTiles = levelData.height
      tileWidth = levelData.tilewidth
      tileHeight = levelData.tileheight

      image = @loader.loadImage levelData.tilesets[0].image
      return unless image

      imageTilesX = Math.floor(image.width / tileWidth)

      for index, currentPos in layer.data
        if index > 0
          x = currentPos % horizontalTiles
          y = Math.floor(currentPos / verticalTiles)

          srcX = ((index-1)%imageTilesX)*tileWidth
          srcY = Math.floor((index-1)/imageTilesX)*tileHeight

          @context.drawImage(
            image,
            srcX,
            srcY,
            tileWidth,
            tileHeight,
            x * tileWidth,
            y * tileHeight,
            tileWidth,
            tileHeight
          )

      undefined