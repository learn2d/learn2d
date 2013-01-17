define [
  'cs!graphics/sprite'
], ->
  # we don't really need this
  Sprite = require 'graphics/sprite'

  class SpriteSheet
    constructor: ->
      @spriteList = []

    addSprite: (viewport, @context, sprite, srcX, srcY, x, y, spriteWidth, spriteHeight) ->
      srcX = Math.floor(srcX)
      srcY = Math.floor(srcY)
      x = Math.floor(x)
      y = Math.floor(y)
      spriteWidth = Math.floor(spriteWidth)
      spriteHeight = Math.floor(spriteHeight)

      drawFunc = sprite.createRenderFunction(
        @context
        srcX
        srcY
      )

      @spriteList.push ->
        drawFunc(
          Math.floor(spriteWidth)
          Math.floor(spriteHeight)
          Math.floor(x * spriteWidth + viewport.offsetX())
          Math.floor(y * spriteHeight + viewport.offsetY())
          Math.floor(spriteWidth)
          Math.floor(spriteHeight)
        )

    render: (context, viewport) ->
      for spriteFunc in @spriteList
        spriteFunc()

      
      #console.log context.canvas.toDataURL()
