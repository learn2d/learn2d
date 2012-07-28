define [
  'cs!util'
], ->
  util = require 'util'

  class AniRenderer
    constructor: (@loader, @context) ->

    render: (ani) ->
      aniData = @loader.loadAni(ani.getName())
      return unless aniData

      direction = util.DIR_UP

      aniX = 0
      aniY = 0

      for frame in aniData.frames[direction]
        for sprite in frame
          spriteId = sprite.id
          spriteData = aniData.sprites[spriteId]

          image = @loader.loadImage spriteData.image
          return unless image

          srcX = spriteData.x
          srcY = spriteData.y

          @context.drawImage(
            image,
            srcX,
            srcY,
            spriteData.width,
            spriteData.height,
            aniX,
            aniY,
            spriteData.width,
            spriteData.height
          )

      undefined