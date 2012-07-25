define ->
  class ResourceLoader
    constructor: ->
      @imageCache = {}

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