define ->

  #### Sprite

  # The sprite is a wrapper around a native Image object, providing an API that
  # allows you to reliably determine
  class Sprite
    constructor: (filename) ->
      # allocate new Image
      @_image = new Image()
      # attach load callback
      @_image.addEventListener 'load', @onLoad.bind(this)
      # start loading image
      @_image.src = "/images/#{filename}"

    # This callback is always called when the image has fully loaded in the
    # browser, even if the image was in the browser cache.
    onLoad: ->
      @image = @_image
      delete @_image

      if @loadedCallbacks isnt undefined
        # run registered callbacks
        for callback in @loadedCallbacks
          callback()

        # clear callback queue
        delete @loadedCallbacks

    # Register a callback to run when the sprite's image has fully loaded.
    # Keep in mind that your callback will be executed outside of the game main
    # loop so don't perform any complex actions.
    # Check if the image has loaded before calling this function:
    #
    #     if sprite.image is undefined
    #       sprite.onImageLoaded myCallback.bind(this)
    #
    onImageLoaded: (callback) ->
      if @loadedCallbacks is undefined
        @loadedCallbacks = []

      @loadedCallbacks.push callback
