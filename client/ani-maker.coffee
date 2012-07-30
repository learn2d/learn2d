#define ->
class aniMaker
  constructor: ->
    @name = 'walk'
    @filenames = ["LM_Female/female_base.png"]
    @xtiles = 8
    @ytiles = 4
    @spritewidth = 64
    @spriteheight = 64
    @xoffset = 1*@spritewidth #remove idle
    @yoffset = 0*@spriteheight #for female sheets
    @frames = []
    @sprites = []
    
  makeFrames: ->
    @frames =
      for dir in [1..@ytiles]
        for layers, idz in @filenames
          for pos in [1..@xtiles]
            id: idz + (dir-1) * @filenames.length
            x: (pos - 1)*@spritewidth + @xoffset
            y: 0

  makeSprites: ->
    for dir in [1..@ytiles]
      for layers, idz in @filenames
        @sprites.push
          image: @filenames[idz]
          x: 0
          y: @spriteheight*(dir - 1) + @yoffset
          width: @spritewidth
          height: @spriteheight

  saveAnimation: ->
    @makeFrames()
    @makeSprites()
    console.log JSON.stringify 
              frames: @frames
              sprites: @sprites

ani = new aniMaker
ani.saveAnimation()
