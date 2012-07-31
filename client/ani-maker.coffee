#define ->
class aniMaker
  constructor: ->
    @name = 'walk'
    @filenames = ["LM_Female/female_base.png"]
    @xtiles = 5
    @ytiles = 1
    @spritewidth = 64
    @spriteheight = 64
    @xoffset = 1*@spritewidth #remove idle
    @yoffset = 12*@spriteheight #for female sheets
    @frames = []
    @sprites = []
    
  makeFrames: ->
    @frames =
      for dir in [1..@ytiles]
        for layers, idz in @filenames
          for pos in [1..@xtiles]
            id: idz + (dir-1) * @filenames.length
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
