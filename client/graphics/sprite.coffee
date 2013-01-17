define ->
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

    # this is used by LevelRenderer
    # it needs to be deleted completely
    createRenderFunction: (context, srcX, srcY) ->
      return (args...) =>
        if @image is undefined
          return

        drawFunc = context.drawImage.bind(
          context
          @image
          Math.floor(srcX)
          Math.floor(srcY)
        )

        drawFunc.apply(context, args)
