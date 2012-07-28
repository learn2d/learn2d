define ->
  class LevelRenderer
    constructor: (@loader, @context) ->

    render: ->
      @levelData = @loader.loadLevel 'test.level'
      return unless @levelData

      @drawLayers()

    drawLayers: ->
      for layer in @levelData.layers
        @drawLayer layer

    drawLayer: (layer) ->
      horizontalTiles = @levelData.width
      verticalTiles = @levelData.height
      tileWidth = @levelData.tilewidth
      tileHeight = @levelData.tileheight

      for index, currentPos in layer.data
        continue unless index != 0

        drawFunc = @getDrawFuncForIndex index
        continue unless drawFunc

        x = currentPos % horizontalTiles
        y = Math.floor(currentPos / verticalTiles)

        drawFunc(
          tileWidth,
          tileHeight,
          x * tileWidth,
          y * tileHeight,
          tileWidth,
          tileHeight
        )

      undefined

    getDrawFuncForIndex: (index) ->
      for tileset, currentPos in @levelData.tilesets
        if tileset.firstgid > index
          break

      tileset = @levelData.tilesets[currentPos - 1]
      imageName = tileset.image

      image = @loader.loadImage imageName
      return null unless image

      tileWidth = @levelData.tilewidth
      tileHeight = @levelData.tileheight
      imageTilesX = Math.floor(tileset.imagewidth / tileWidth)

      firstgid = tileset.firstgid
      srcX = ((index - firstgid) % imageTilesX) * tileWidth
      srcY = Math.floor((index - firstgid) / imageTilesX) * tileHeight

      drawFunc = @context.drawImage.bind(
        @context,
        image,
        srcX,
        srcY
      )

      return drawFunc