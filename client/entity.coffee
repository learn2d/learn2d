define [
  'cs!ani'
], ->
  Ani = require 'ani'

  class AniComponent
    constructor: ([{@x, @y, @aniName, @direction}]) ->
      @anis = [
        new Ani
          x: @x
          y: @y
          aniName: @aniName
          direction: @direction
      ]
    getAnis: =>
      @anis

  class Entity
    constructor: ({@x, @y, @aniName, @direction}) ->
      @components = {}
      @components.ani = new AniComponent([{@x, @y, @aniName, @direction}])