define [
  'cs!util'
], ->
  util = require 'util'

  class Ani
    constructor: ({@entity, @x, @y}) ->
      @lastFrame = 0
      @nextTime = new Date().getTime()
      @delay = 50
      @files = ["JS_Male/png/walkcycle/BODY_male.png","JS_Male/png/walkcycle/TORSO_leather_armor_torso.png","JS_Male/png/walkcycle/TORSO_plate_armor_arms_shoulders.png","JS_Male/png/walkcycle/FEET_plate_armor_shoes.png","JS_Male/png/walkcycle/LEGS_pants_greenish.png","JS_Male/png/walkcycle/HEAD_chain_armor_helmet.png"]

    getDirection: ->
      @entity.getDirection()

    getX: ->
      @entity.getX() + @x

    getY: ->
      @entity.getY() + @y

    getName: ->
      @entity.getAniName()

    getDelay: ->
      @delay

    getFiles: ->
      @files

    getLastFrame: ->
      @lastFrame
    setLastFrame: (frameNum) ->
      @lastFrame = frameNum

    getNextTime: ->
      @nextTime
    setNextTime: () ->
      @nextTime = new Date().getTime() + @delay
