define ->

  #### SpriteSheet

  class SpriteSheet
    constructor: ->
      @spriteList = []
      @buffer = document.createElement('canvas').getContext('2d')
      @width = 0
      @height = 0
      @dirty = false

    addSprite: (sprite, srcX, srcY, x, y, spriteWidth, spriteHeight) ->
      srcX = ~~(srcX)
      srcY = ~~(srcY)
      x = ~~(x)
      y = ~~(y)
      spriteWidth = ~~(spriteWidth)
      spriteHeight = ~~(spriteHeight)

      if @width < x + spriteWidth
        @width = x + spriteWidth
      if @height < y + spriteHeight
        @height = y + spriteHeight

      @spriteList.push [
        sprite,
        srcX,
        srcY,
        x,
        y,
        spriteWidth,
        spriteHeight
      ]

      # mark the sheet dirty now and also when this sprite finishes loading
      @dirty = true
      if sprite.image is undefined
        sprite.onImageLoaded @markDirty.bind(this)

      return

    markDirty: ->
      @dirty = true

      return

    render: (context, viewport, renderX = 0, renderY = 0) ->
      # at least one valid sprite is required for this operation to succeed
      if @width is 0 or @height is 0
        return

      renderX = ~~(renderX)
      renderY = ~~(renderY)

      # sheet has become dirty, i.e. a new image has finished downloading
      if @dirty
        @dirty = false
        @buffer.canvas.width = @width
        @buffer.canvas.height = @height

        for spriteData in @spriteList
          [sprite, srcX, srcY, x, y, spriteWidth, spriteHeight] = spriteData

          # check if image has loaded yet
          spriteImage = sprite.image
          if spriteImage is undefined
            continue

          @buffer.drawImage(
            spriteImage
            srcX
            srcY
            spriteWidth
            spriteHeight
            x
            y
            spriteWidth
            spriteHeight
          )

      # draw pre-rendered layers
      context.drawImage(
        @buffer.canvas
        0
        0
        @width
        @height
        viewport.offsetX() + renderX
        viewport.offsetY() + renderY
        @width
        @height
      )

      return
