#define ->
class aniMaker
  constructor: ->
    @name = 'walk'
    @filenames = ["LM_Female/female_base.png","JS_Male/png/walkcycle/BELT_leather.png", "JS_Male/png/walkcycle/HANDS_plate_armor_gloves.png"]
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

  makeSprites: ->
    for dir in [1..@ytiles]
      for layers, idz in @filenames
        @sprites.push
          image: @filenames[idz]
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
