define [
  'cs!game',
  'cs!resource-loader',
  'json'
], () ->
  Game = require 'game'
  ResourceLoader = require 'cs!resource-loader'

  document.addEventListener 'mousedown', ->
    false

  canvas = document.getElementById("myCanvas")
  context = canvas.getContext("2d")

  resourceLoader = new ResourceLoader()
  game = new Game(resourceLoader, context)

  game.init()