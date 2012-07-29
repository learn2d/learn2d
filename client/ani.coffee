define ->
  class Ani
    constructor: ->
      @name = 'walk'
      @IsAnimating = 1
      @LastFrame = 0
      @NextTime = new Date().getTime()
      @delay = 50
      @xpos = 100
      @ypos = 100
      
    getXpos: ->
      @xpos
    setXpos: (newx) ->
      @xpos = newx

    getYpos: ->
      @ypos
    setYpos: (newy) ->
      @ypos = newy

    getName: ->
      @name
    getDelay: ->
      @delay

    getLastFrame: ->
      @LastFrame
    setLastFrame: (frameNum) ->
      @LastFrame = frameNum

    getNextTime: ->
      @NextTime
    setNextTime: () ->
      @NextTime = new Date().getTime() + @delay

    getIsAnimating: ->
      @IsAnimating
    SetIsAnimating: (bool) ->
      @IsAnimating = bool

