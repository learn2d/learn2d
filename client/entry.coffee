define [
  'game',
  'cs!resource-loader'
], () ->
  Game = require 'game'
  ResourceLoader = require 'cs!resource-loader'

  document.addEventListener 'mousedown', ->
    false

  resourceLoader = new ResourceLoader()
  game = new Game()

  game.init(resourceLoader)