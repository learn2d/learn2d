define [
  'cs!ani'
], ->
  Ani = require 'ani'

  class Entity
    constructor: ({@x, @y, @level}) ->
      @components = {}
      @components.ani =
        getAnis: =>
          [
            new Ani
              x: @x,
              y: @y
          ]
