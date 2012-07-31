define [
  'cs!util'
], ->
  util = require 'util'

  class AniRenderer
    constructor: (@loader, @context) ->

    render: (ani) ->
      aniData = @loader.loadAni(ani.getName())
      return unless aniData

      direction = ani.getDirection()

      aniX = ani.getX()
      aniY = ani.getY()

      index = ani.getLastFrame()
      time = new Date().getTime()
      nextTime = ani.getNextTime()
      
      if time > nextTime
        index++
        ani.setNextTime()
        if index < aniData.frames[direction][0].length
          ani.setLastFrame(index)
        else
          index = 0
          ani.setLastFrame(0)

      for file, idx in ani.getFiles()

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
