#define ->
class aniMaker
  constructor: ->
    @name = 'walk'
    @filenames = ["null"]
    @xtiles = 3
    @ytiles = 4
    @spritewidth = 32
    @spriteheight = 32
    @xoffset = 0*@spritewidth #remove idle
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
