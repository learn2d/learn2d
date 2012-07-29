#define ->
class aniMaker
  constructor: ->
    @name = 'walk'
    @filenames = ["bodies/BODY_male.png", "bodies/FEET_shoes_brown.png", "bodies/LEGS_robe_skirt.png", "bodies/TORSO_chain_armor_torso.png", "bodies/BELT_rope.png", "bodies/HEAD_hair_blonde.png", "bodies/HEAD_leather_armor_hat.png"]
    @xtiles = 9
    @ytiles = 4
    @spritewidth = 64
    @spriteheight = 64
    @frames = []
    @sprites = []
    
  makeFrames: ->
    @frames =
      for dir in [1..@ytiles]
        for layers, idz in @filenames
          for pos in [1..@xtiles]
            id: idz + (dir-1) * @filenames.length
            x: (pos - 1)*@spritewidth

  makeSprites: ->
    for dir in [1..@ytiles]
      for layers, idz in @filenames
        @sprites.push
          image: @filenames[idz]
          y: @spriteheight*(dir - 1)
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
