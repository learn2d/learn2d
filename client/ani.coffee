define ->
  class Ani
    constructor: ->
      @name = 'walk'
      @IsAnimating = 1
      @LastFrame = 0

    getName: ->
      @name
    getLastFrame: ->
      @LastFrame
    setLastFrame: (frameNum) ->
      @LastFrame = frameNum
    getIsAnimating: ->
      @IsAnimating
