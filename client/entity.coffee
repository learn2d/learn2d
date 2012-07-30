define [
  'cs!ani'
], ->
  Ani = require 'ani'

  class AniComponent
    constructor: ({@x, @y}) ->
      @anis = [
        new Ani
          x: @x,
          y: @y
      ]
    getAnis: =>
      @anis

  class Entity
    constructor: ({@x, @y, @level}) ->
      @components = {}
      @components.ani = new AniComponent({@x, @y})