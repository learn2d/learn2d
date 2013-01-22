define [
  'cs!graphics/sprite'
], ->
  # we don't really need this
  Sprite = require 'graphics/sprite'

  class SpriteSheet
    constructor: ->
      @spriteList = []
      @buffer = document.createElement('canvas').getContext('2d')
      @lastRenderTime = 0
      @width = 0
      @height = 0

    addSprite: (context, sprite, srcX, srcY, x, y, spriteWidth, spriteHeight) ->
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

      return

    render: (context, viewport, renderX = 0, renderY = 0) ->
      unless @width isnt 0 and @height isnt 0
        return

      # how long to wait before re-rendering the sprite sheet
      # need to replace this with automatic detection that the layers
      # have become dirty, i.e. a new tileset image has finished downloading
      timeBetweenRenders = 30000
      if Date.now() - @lastRenderTime > timeBetweenRenders
        @buffer.canvas.width = @width
        @buffer.canvas.height = @height

        @lastRenderTime = Date.now()

        for spriteData in @spriteList
          [sprite, srcX, srcY, x, y, spriteWidth, spriteHeight] = spriteData

          drawFunc = sprite.createRenderFunction(
            @buffer
            srcX
            srcY
          )

          drawFunc(
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

      #console.log context.canvas.toDataURL()
