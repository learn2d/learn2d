define [
  'cs!game'
  'cs!resource-loader'
  'json'
  'cs!network'
], () ->
  Network = require 'network'
  Game = require 'game'
  ResourceLoader = require 'cs!resource-loader'

  document.addEventListener 'mousedown', ->
    false

  canvas = document.getElementById("canvas")
  canvas.width = 1024
  canvas.height = 1024
  context = canvas.getContext("2d")

  resourceLoader = new ResourceLoader()
  network = new Network()
  game = new Game(resourceLoader, context, network)

  game.start()