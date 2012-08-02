define ->
  class LevelRenderer
    constructor: (@loader, @context) ->

    render: (level, layername) ->
      return if level is null

      levelData = level.getLevelData()
      return unless levelData

      @drawLayers(levelData, layername)

    drawLayers: (levelData, layername) ->
      for layer in levelData.layers
        if layer.name == layername
          @drawLayer levelData, layer
        if layer.name == 'collisions'
          @drawLayer levelData, layer

    drawLayer: (levelData, layer) ->
      # only draw tile layers
      return unless layer.type is 'tilelayer'
      # dont draw collision layers
      # disable for now
      return if false and layer.name in ['collisions', 'collision']

      horizontalTiles = levelData.width
      verticalTiles = levelData.height
      tileWidth = levelData.tilewidth
      tileHeight = levelData.tileheight

      for index, currentPos in layer.data
        continue unless index != 0

        drawFunc = @getDrawFuncForIndex levelData, index
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

    getDrawFuncForIndex: (levelData, index) ->
      for tileset, currentPos in levelData.tilesets
        if tileset.firstgid > index
          break

      tileset = levelData.tilesets[currentPos - 1]
      imageName = tileset.image

      image = @loader.loadImage imageName
      return null unless image

      tileWidth = levelData.tilewidth
      tileHeight = levelData.tileheight
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
