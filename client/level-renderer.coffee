define [
  'cs!graphics/sprite-sheet'
], ->
  SpriteSheet = require 'graphics/sprite-sheet'

  class LevelRenderer
    constructor: (@loader, @context, @viewport) ->

    renderLayers: (level, layername) ->
      # when does this happen?
      return if level is null

      # check if exported Tiled map data is available
      levelData = level.getLevelData()
      return unless levelData

      # check if sprite sheet has been created
      if level.spriteSheets[layername] is undefined
        # need to initialize new sprite sheet
        level.spriteSheets[layername] = new SpriteSheet()

        # configure sprite sheet for these layers
        @configureLayers(levelData, layername, level.spriteSheets[layername])

      # render these layers combined into sprite sheet
      level.spriteSheets[layername].render(
        @context
        @viewport
      )

    configureLayers: (levelData, layername, spriteSheet) ->
      for layer in levelData.layers
        if layer.name == layername
          @configureLayer levelData, layer, spriteSheet

    configureLayer: (levelData, layer, spriteSheet) ->
      # only draw tile layers
      return unless layer.type is 'tilelayer'
      # dont draw collision layers
      return if layer.name in ['collisions', 'collision']
      # comment next line to hide collision map
      #return if false and layer.name in ['collisions', 'collision']

      horizontalTiles = levelData.width
      verticalTiles = levelData.height
      tileWidth = levelData.tilewidth
      tileHeight = levelData.tileheight

      for index, currentPos in layer.data
        continue unless index != 0

        [sprite, srcX, srcY] = @getDrawFuncForIndex levelData, index

        x = currentPos % horizontalTiles
        y = Math.floor(currentPos / verticalTiles)

        spriteSheet.addSprite(
          @viewport
          @context
          sprite
          srcX
          srcY
          x * tileWidth
          y * tileHeight
          tileWidth
          tileHeight
        )

      undefined

    getDrawFuncForIndex: (levelData, index) ->
      # loop over tilesets until we match firstgid with the current image index
      # from the tile data
      for tileset, currentPos in levelData.tilesets
        if tileset.firstgid > index
          break
      # decrease current tileset by one to account for passing the correct
      # tileset
      tileset = levelData.tilesets[currentPos - 1]
      # get image filename for index
      imageName = tileset.image

      # load Sprite for this filename
      sprite = @loader.loadImage imageName

      tileWidth = levelData.tilewidth
      tileHeight = levelData.tileheight
      imageTilesX = Math.floor(tileset.imagewidth / tileWidth)

      firstgid = tileset.firstgid
      srcX = ((index - firstgid) % imageTilesX) * tileWidth
      srcY = Math.floor((index - firstgid) / imageTilesX) * tileHeight

      return [sprite, srcX, srcY]
