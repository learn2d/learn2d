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

      aniX = 100
      aniY = 100
      index = 0
      
      if ani.getIsAnimating()
        index = ani.getLastFrame()
        index++
        if index < aniData.frames[direction][0].length
          ani.setLastFrame(index)
        else
          index = 0
          ani.setLastFrame(0)
      else
        ani.setLastFrame(0)


      for frame, idx in aniData.frames[direction]
        break if idx == 1 # we dont support multiple frames

        frame = aniData.frames[direction][idx][index]
        sprite = frame
        spriteId = sprite.id
        spriteData = aniData.sprites[spriteId]

        image = @loader.loadImage spriteData.image
        return unless image

        srcX = sprite.x
        srcY = spriteData.y

        @context.drawImage(
          image,
          srcX,
          srcY,
          spriteData.width,
          spriteData.height,
          aniX + 0,
          aniY + 0,
          spriteData.width,
          spriteData.height
        )

      undefined
