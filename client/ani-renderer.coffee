define [
  'cs!util'
], ->
  util = require 'util'

  class AniRenderer
    constructor: (@loader, @context, @viewport) ->

    render: (ani, health) ->
      aniData = @loader.loadAni(ani.getName())
      return unless aniData

      direction = ani.getDirection()

      aniX = ani.getX()
      aniY = ani.getY()

      index = ani.getLastFrame()

      index += 1

      if index < aniData.frames[direction][0].length
        ani.setLastFrame(index)
      else
        index = 0
        ani.setLastFrame(index)

      for file, idx in ani.getSpriteList()

        frame = aniData.frames[direction][0][index]
        sprite = frame
        spriteId = sprite.id
        spriteData = aniData.sprites[spriteId]

        image = @loader.loadImage file
        return unless image

        srcX = sprite.x
        srcY = sprite.y

        @context.drawImage(
          image,
          Math.floor(srcX)
          Math.floor(srcY)
          Math.floor(spriteData.width)
          Math.floor(spriteData.height)
          Math.floor(aniX + 0 + @viewport.offsetX())
          Math.floor(aniY + 0 + @viewport.offsetY())
          Math.floor(spriteData.width)
          Math.floor(spriteData.height)
        )

      image = @loader.loadImage "fantasy/ui/bar_hp.png"
      return unless image
      @context.drawImage(
        image,
        0
        0
        Math.floor((health/100)*image.width)
        image.height
        Math.floor(aniX + 0 + @viewport.offsetX())
        Math.floor(aniY + Math.floor(spriteData.height) + @viewport.offsetY())
        Math.floor((health/100)*spriteData.width)
        10
      )
#      console.log health
      undefined
