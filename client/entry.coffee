# Define this as a global so we can have prettier module scripts
# It'll add the API modules as instance properties so we don't have to do it
# every time in each modules
class window.PlayerModule
  constructor: ({@player, @timer, @util, @input, @level, @trigger}) ->

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

  resize()
  window.addEventListener 'resize', lodash.debounce(resize, 200)

  resourceLoader = new ResourceLoader()
  context = canvas.getContext("2d")
  network = new Network()
  game = new Game(resourceLoader, context, network)

  game.start()