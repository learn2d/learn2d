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

      aniX = ani.getXpos()
      aniY = ani.getYpos()

      index = ani.getLastFrame()
      time = new Date().getTime()
      nextTime = ani.getNextTime()
      
      if ani.getIsAnimating()
        if time > nextTime
          index++
          ani.setNextTime()
          if index < aniData.frames[direction][0].length
            ani.setLastFrame(index)
          else
            index = 1
            ani.setLastFrame(1)
      else
        ani.setLastFrame(0)


      for frame, idx in aniData.frames[direction]

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
