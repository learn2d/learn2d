uuid = require 'node-uuid'
util = require './util'

class Entity
  constructor: ({@id, @x, @y, @aniName, @direction, @visible, @type, @test}) ->
    @direction ?= util.DIR_UP
    @aniName ?= 'female-walk'
    @id ?= uuid.v1()
    @visible ?= true
    @test = []
    @spritedata = [["LM_Female/female_base.png", "LM_Female/female_base_shadow.png", "LM_Female/female_base_blue.png", "LM_Female/female_base_grey.png", "LM_Female/female_base_yellow.png", "LM_Female/female_base_white.png", "LM_Female/female_base_pink.png", "LM_Female/female_base_brown.png", "LM_Female/female_base_green.png", "LM_Female/female_base_glow.png", "LM_Female/female_base_iceblue.png", "LM_Female/female_base_purple.png"], ["LM_Female/robes/female_mage_lightgrayrobe.png", "LM_Female/robes/female_mage_brightroyalbluerobe.png", "LM_Female/robes/female_mage_blackrobe.png", "LM_Female/robes/female_mage_brightpurplerobe.png", "LM_Female/robes/female_mage_brighttealrobe.png", "LM_Female/robes/female_mage_brightgreenrobe.png", "LM_Female/robes/female_mage_brightnavybluerobe.png", "LM_Female/robes/female_mage_redrobe.png", "LM_Female/robes/female_mage_darkgrayrobe.png", "LM_Female/robes/female_mage_whiterobe.png", "LM_Female/robes/female_mage_brightorangerobe.png", "LM_Female/robes/female_mage_darkbrownrobe.png", "LM_Female/robes/female_mage_brownrobe.png", "LM_Female/robes/female_mage_purplerobe.png", "LM_Female/robes/female_mage_forestrobe.png", "LM_Female/robes/female_mage_brightredrobe.png", "LM_Female/robes/female_mage_brightyellowrobe.png", "LM_Female/robes/female_mage_bluerobe.png"], ["LM_Female/hair/female_mage_blackhair.png", "LM_Female/hair/female_mage_goldenhair.png", "LM_Female/hair/female_mage_midnightbluehair.png", "LM_Female/hair/female_mage_pinkhair.png", "LM_Female/hair/female_mage_whitehair.png", "LM_Female/hair/female_mage_grayhair.png", "LM_Female/hair/female_mage_forestgreenhair.png", "LM_Female/hair/female_mage_skybluehair.png", "LM_Female/hair/female_mage_purplehair.png", "LM_Female/hair/female_mage_tealhair.png", "LM_Female/hair/female_mage_darkblondehair.png", "LM_Female/hair/female_mage_fireredhair.png", "LM_Female/hair/female_mage_brownhair.png", "LM_Female/hair/female_mage_lightblondehair.png"], ["LM_Female/belts/female_mage_bronzebelt.png", "LM_Female/belts/female_mage_ironbelt.png", "LM_Female/belts/female_mage_redbelt.png", "LM_Female/belts/female_mage_purplebelt.png", "LM_Female/belts/female_mage_silverbelt.png", "LM_Female/belts/female_mage_blackbelt.png", "LM_Female/belts/female_mage_royalbluebelt.png", "LM_Female/belts/female_mage_greenbelt.png", "LM_Female/belts/female_mage_yellowbelt.png", "LM_Female/belts/female_mage_tealbelt.png", "LM_Female/belts/female_mage_brownbelt.png", "LM_Female/belts/female_mage_goldbelt.png"],["LM_Female/buckles/female_mage_goldbuckle.png", "LM_Female/buckles/female_mage_silverbuckle.png", "LM_Female/buckles/female_mage_ironbuckle.png", "LM_Female/buckles/female_mage_bronzebuckle.png"],["LM_Female/tiaras/female_mage_irontiara.png", "LM_Female/tiaras/female_mage_bronzetiara.png", "LM_Female/tiaras/female_mage_silvertiara.png", "LM_Female/tiaras/female_mage_goldtiara.png"],["LM_Female/slippers/female_mage_grayslippers.png", "LM_Female/slippers/female_mage_brownslippers.png", "LM_Female/slippers/female_mage_blackslippers.png", "LM_Female/slippers/female_mage_whiteslippers.png"],["LM_Female/necklaces/female_mage_silvernecklace.png", "LM_Female/necklaces/female_mage_goldnecklace.png", "LM_Female/necklaces/female_mage_bronzenecklace.png", "LM_Female/necklaces/female_mage_ironnecklace.png"],["LM_Female/dagger.png"]]
    
    for spritesheet, i in @spritedata
      variety = Math.floor(Math.random()*spritesheet.length)
      @test.push spritesheet[variety]

  getX: ->
    @x

  setX: (x) ->
    @x = x

  getY: ->
    @y

  setY: (y) ->
    @y = y

  getAniName: ->
    @aniName

  setAniName: (aniName) ->
    @aniName = aniName

  getDirection: ->
    @direction

  setDirection: (direction) ->
    @direction = direction

  toJSON: ->
    id: @id
    x: @x
    y: @y
    direction: @direction
    aniName: @aniName
    visible: @visible
    test: @test

module.exports = Entity
