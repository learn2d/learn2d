#define ->
class aniMaker
  constructor: ->
    @name = 'explosion'
    @filenames = ["null"]
    @xtiles = 4
    @ytiles = 5
    @spritewidth = 128
    @spriteheight = 128
    @xoffset = 0*@spritewidth #remove idle
    @yoffset = 0*@spriteheight #for female sheets
    @frames = []
    @sprites = []
    
  makeFrames: ->
      for dir in [1..@ytiles]
        for pos in [1..@xtiles]
          @frames.push
            x: (pos - 1)*@spritewidth + @xoffset
            y: @spriteheight*(dir - 1) + @yoffset

  makeSprites: ->
    for dir in [1..@ytiles]
      for layers, idz in @filenames
        @sprites.push
          #tilesetOffset
#          x: 0 
#          y: 0
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
