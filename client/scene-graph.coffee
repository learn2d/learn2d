define [
  'cs!level'
  'cs!ani'
  'cs!entity'
], ->
  Level = require 'level'
  Ani = require 'ani'
  Entity = require 'entity'

  class SceneGraph
    constructor: () ->
      @reset {}

    getLevel: () ->
      @level

    addEntity: (entity) ->
      @entities.push entity

    addEntityFromData: (entityData) ->
      console.log 'adding entity'
      console.log entityData

      entity = new Entity
        x: entityData.x
        y: entityData.y
      @entities.push entity

    getEntities: () ->
      @entities

    reset: ({level, entities}) ->
      @entities = []
      if typeof entities is 'object'
        for entityData in entities
          @addEntityFromData entityData

      if level
        @level = new Level(level)
      else
        @level = null