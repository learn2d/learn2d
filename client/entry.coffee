define [
  'cs!game'
  'cs!resource-loader'
  'json'
  'cs!network'
  'lodash'
], () ->
  lodash = require 'lodash'

  Network = require 'network'
  Game = require 'game'
  ResourceLoader = require 'cs!resource-loader'

  document.addEventListener 'mousedown', ->
    false

  canvas = document.getElementById 'canvas'

  resize = ->
    if window.innerWidth > 1024
      canvas.width = 1024
    else
      canvas.width = window.innerWidth

    if window.innerHeight > 1024
      canvas.height = 1024
    else
      canvas.height = window.innerHeight

  context = canvas.getContext("2d")

  resize()
  window.addEventListener 'resize', lodash.debounce(resize, 200)

  resourceLoader = new ResourceLoader()
  network = new Network()
  game = new Game(resourceLoader, context, network)

  game.start()