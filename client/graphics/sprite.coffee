define ->
  noop = ->

  class Sprite
    constructor: (filename) ->
      # reset state
      @loaded = false
      # allocate new Image
      @_image = new Image()
      # attach load callback
      @_image.addEventListener 'load', @onLoad.bind(this)
      # start loading image
      @_image.src = "/images/#{filename}"

    onLoad: ->
      @image = @_image
      @_image = undefined

    createRenderFunction: (context, srcX, srcY) ->
      if @image is undefined
        return noop

      return context.drawImage.bind(
        context
        @image
        Math.floor(srcX)
        Math.floor(srcY)
      )
