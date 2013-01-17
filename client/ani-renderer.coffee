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

        spriteResource = @loader.loadImage file
        if spriteResource.image is undefined
          continue

        srcX = sprite.x
        srcY = sprite.y

        @context.drawImage(
          spriteResource.image,
          Math.floor(srcX)
          Math.floor(srcY)
          Math.floor(spriteData.width)
          Math.floor(spriteData.height)
          Math.floor(aniX + 0 + @viewport.offsetX())
          Math.floor(aniY + 0 + @viewport.offsetY())
          Math.floor(spriteData.width)
          Math.floor(spriteData.height)
        )

      # load health bar image
      return
      sprite = @loader.loadImage "fantasy/ui/bar_hp.png"
      if sprite.image is undefined
        return
      # draw health bar
      @context.drawImage(
        sprite.image,
        0
        0
        Math.floor((health/100)*sprite.image.width)
        sprite.image.height
        Math.floor(aniX + 0 + @viewport.offsetX())
        Math.floor(aniY + Math.floor(spriteData.height) + @viewport.offsetY())
        Math.floor((health/100)*spriteData.width)
        10
      )
      return
