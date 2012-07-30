define [
  'cs!level'
  'cs!ani'
], ->
  Level = require 'level'
  Ani = require 'ani'

  class SceneGraph
    constructor: () ->
      @reset {}

    getLevel: () ->
      @level

    addEntity: (entity) ->
      @entities.push entity

    getEntities: () ->
      @entities

    reset: ({level}) ->
      @entities = []
      if level
        @level = new Level(level)
      else
        @level = null