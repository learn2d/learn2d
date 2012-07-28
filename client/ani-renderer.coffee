define [
  'cs!util'
], ->
  util = require 'util'

  class AniRenderer
    constructor: (@loader, @context) ->

    render: (ani) ->
      aniData = @loader.loadAni(ani.getName())
      return unless aniData

      direction = util.DIR_RIGHT

      aniX = 0
      aniY = 0

      for frame, idx in aniData.frames[direction]
        break if idx == 1 # we dont support multiple frames

        for sprite in frame
          spriteId = sprite.id
          spriteData = aniData.sprites[spriteId]

          image = @loader.loadImage spriteData.image
          return unless image

          srcX = spriteData.x
          srcY = spriteData.y

          partX = sprite.x
          partY = sprite.y

          @context.drawImage(
            image,
            srcX,
            srcY,
            spriteData.width,
            spriteData.height,
            aniX + partX,
            aniY + partY,
            spriteData.width,
            spriteData.height
          )

      undefined