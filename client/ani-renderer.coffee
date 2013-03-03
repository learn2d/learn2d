define [
  'canvastext'
  'cs!graphics/sprite-sheet'
], ->
  CanvasText = require 'canvastext'
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

      testText = new CanvasText()

      testText.config
        canvasId: 'canvas'
        fontFamily: 'Verdana'
        fontSize: '14px'
        fontWeight: 'normal'
        fontColor: '#000'
        lineHeight: '12'

      testText.defineClass 'blue',
        fontSize: "24px"
        fontColor: "#29a1f1"
        fontFamily: "Impact"
        fontWeight: "normal"

      testText.defineClass 'pink',
        fontSize: "24px"
        fontColor: "#ff5e99"
        fontFamily: "Times new roman"
        fontWeight: "bold"

      text = 'I like <class="blue">blue</class> color but I also like <class="pink">pink</class> color!'
      text = text + '<br />Nevermind, I prefer <class="blue">blue</class> to <class="pink">pink</class>... ;)!'

      testText.drawText
        text: text
        x: 20
        y: 30

      return
