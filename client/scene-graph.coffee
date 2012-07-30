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
      console.log 'entity added'

    addEntityFromData: (entityData) ->
      entity = new Entity
        x: entityData.x
        y: entityData.y
      @addEntity entity

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