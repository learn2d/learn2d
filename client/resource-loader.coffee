define ->
  class ResourceLoader
    constructor: ->
      @imageCache = {}
      @levelCache = {}
      @aniCache = {}

    loadImage: (imageName) ->
      cachedImage = @imageCache[imageName]

      if cachedImage is null
        null
      else if not cachedImage?
        image = new Image()
        image.addEventListener 'load', =>
          @imageCache[imageName] = image
        image.src = imageName

        # avoid adding this image to cache again
        @imageCache[imageName] = null

        null
      else
        cachedImage

    loadLevel: (levelName) ->
      cachedLevel = @levelCache[levelName]

      if cachedLevel is null
        null
      else if not cachedLevel?
        require ["json!#{levelName}.level.json"], (levelData) =>
          @levelCache[levelName] = levelData

        # avoid adding this image to cache again
        @levelCache[levelName] = null

        null
      else
        cachedLevel


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