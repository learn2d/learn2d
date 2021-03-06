define [
  'cs!graphics/sprite-sheet'
], ->
  SpriteSheet = require 'graphics/sprite-sheet'

  class AniRenderer
    constructor: (@loader, @context, @viewport) ->

    render: (entity, health) ->
      # load animation data from JSON file
      aniName = entity.aniName
      aniData = @loader.loadAni aniName
      return unless aniData

      # get entity coordinates and direction
      aniX = entity.ani.getX()
      aniY = entity.ani.getY()
      direction = entity.direction

      # get index for next frame
      index = entity.ani.lastFrame + 1

      # check if exceeded length of animation
      if index >= aniData.frames[direction][0].length
        index = 0

      # save current frame to ani
      entity.ani.lastFrame = index

      # get pre-rendered animation frame from Entity
      renderedFrame = entity.renderedFrames[aniName]?[direction]?[index]

      # if this frame doesn't have a SpriteSheet created for it yet,
      # then create one and save it to the Entity
      if renderedFrame is undefined
        entity.renderedFrames[aniName] ||= []
        renderedAni = entity.renderedFrames[aniName]
        renderedAni[direction] ||= []
        renderedFrame = new SpriteSheet()
        renderedAni[direction][index] = renderedFrame

        for file, idx in entity.SpriteList
          frame = aniData.frames[direction][0][index]
          sprite = frame
          spriteId = sprite.id
          spriteData = aniData.sprites[spriteId]

          spriteResource = @loader.loadImage file

          srcX = sprite.x
          srcY = sprite.y

          renderedFrame.addSprite(
            spriteResource
            srcX
            srcY
            0
            0
            spriteData.width
            spriteData.height
          )

      renderedFrame.render(
        @context
        @viewport
        aniX
        aniY
      )

      # load health bar image
      ###
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
      ###

      return
