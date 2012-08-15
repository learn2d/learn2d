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
      console.log "SETTING PLAYER BY ID"
      @player = @getEntityById id
      console.log "PLAYER"
      console.log @player
      console.log @level
      throw new Error "Could not set player to #{id}" unless @player

    getPlayerLevel: () ->
      @level

    addEntity: (entity) ->
      console.log "Adding Entity inspite of best intentions"
      @entities.push entity

    removeEntity: (id) ->
      index = @getEntityIndex id
      console.log "Removing Entity!"
      console.log "Removing Entity!"
      console.log index
      console.log @entities.length
      @entities.splice(index,1)
      console.log @entities.length
      console.log "Entity Removed! " + @entities.length
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
        test: entityData.test
      @addEntity entity

    getEntities: () ->
      @entities

    getEntityById: (id) ->
      for entity in @entities
        if (entity.id is id)
          return entity

      undefined

    reset: ({levelName, entities}) ->
      console.log "INITIATING RESET!!!!!!!!!!!"
      @player = undefined
      @entities = []
      if typeof entities is 'object'
        for entityData in entities
          @addEntityFromData entityData
      console.log "in scenegraph reset mode"
      console.log @entities
      console.log levelName
      console.log "/end reset mode"
      if levelName
        @level = new Level
          loader: @loader
          levelName: levelName
      else
        @level = null       
