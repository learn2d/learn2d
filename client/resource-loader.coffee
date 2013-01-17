define ->
  class ResourceLoader
    constructor: ->
      @imageCache = {}
      @levelCache = {}
      @aniCache = {}

    loadImage: (imageName) ->
      cachedImage = @imageCache[imageName]

      if cachedImage is null
        return null
      else if cachedImage isnt undefined
        return cachedImage
      else
        image = new Image()
        image.addEventListener 'load', =>
          @imageCache[imageName] = image
        image.src = "images/#{imageName}"

        # avoid adding this image to cache again
        @imageCache[imageName] = null

        return null

    loadLevel: (levelName) ->
      cachedLevel = @levelCache[levelName]

      if cachedLevel is null
        null
      else if not cachedLevel?
        require ["json!levels/#{levelName}.level.json"], (levelData) =>
          levelData.collisionData = @_buildCollisions(levelData)
          levelData.warpData = @_buildWarps(levelData)
          @levelCache[levelName] = levelData

        # avoid adding this image to cache again
        @levelCache[levelName] = null

        null
      else
        cachedLevel

    _buildCollisions: (levelData) ->
      collisionMap = []

      for layer in levelData.layers
        if layer.name in ['collision', 'collisions']
          for tileData, tileIndex in layer.data
            if tileData isnt 0
              collisionMap[tileIndex] = true
            else if collisionMap[tileIndex] is undefined
              collisionMap[tileIndex] = false

      return collisionMap

    _buildWarps: (levelData) ->
      warps = []

      for layer in levelData.layers
        if layer.name in ['event']
          for objectData in layer.objects
            warpData = objectData.properties?.warp
            if warpData
              warpParts = warpData.split ','
              warps.push
                x: objectData.x
                y: objectData.y
                width: objectData.width
                height: objectData.height
                destLevelName: warpParts[0]
                destX: Number(warpParts[1])
                destY: Number(warpParts[2])

      return warps

    loadAni: (aniName) ->
      cachedAni = @aniCache[aniName]

      if cachedAni is null
        null
      else if not cachedAni?
        require ["json!anis/#{aniName}.ani.json"], (aniData) =>
          @aniCache[aniName] = aniData

        # avoid adding this image to cache again
        @aniCache[aniName] = null

        null
      else
        cachedAni