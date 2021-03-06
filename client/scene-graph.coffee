define [
  'cs!level'
  'cs!ani'
  'cs!entity'
  'cs!util'
], ->
  util = require 'util'
  Level = require 'level'
  Ani = require 'ani'
  Entity = require 'entity'

  class SceneGraph
    constructor: (@loader) ->
      @reset {}

    getPlayer: ->
      @player

    setPlayerById: (id) ->
      @player = @getEntityById id
      throw new Error "Could not set player to #{id}" unless @player

    getPlayerLevel: () ->
      @level

    addEntity: (entity) ->
      @entities.push entity

    removeEntity: (id) ->
      index = @getEntityIndex id
      @entities.splice(index,1)
      undefined

    getEntityIndex: (id) ->
      for checkid, i in @entities
        if id == @entities[i].id
          return i
      undefined

    addEntityFromData: (entityData) ->
      entity = new Entity
        x: entityData.x
        y: entityData.y
        aniName: entityData.aniName
        direction: entityData.direction
        id: entityData.id
        visible: entityData.visible
        SpriteList: entityData.SpriteList
        health: entityData.health
      @addEntity entity

    getEntities: () ->
      @entities

    getEntityById: (id) ->
      for entity in @entities
        if (entity.id is id)
          return entity

      undefined

    reset: ({levelName, entities}) ->
      @player = undefined
      @entities = []
      if typeof entities is 'object'
        for entityData in entities
          @addEntityFromData entityData
      if levelName
        @level = new Level
          loader: @loader
          levelName: levelName
      else
        @level = null       
