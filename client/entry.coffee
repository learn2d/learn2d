define [
  'cs!game'
  'cs!resource-loader'
  'json'
], () ->
  Game = require 'game'
  ResourceLoader = require 'cs!resource-loader'

  document.addEventListener 'mousedown', ->
    false

  canvas = document.getElementById("canvas")
  canvas.width = 1024
  canvas.height = 1024
  context = canvas.getContext("2d")

  resourceLoader = new ResourceLoader()
  game = new Game(resourceLoader, context)

  socket = io.connect 'http://localhost:3001'
  socket.on 'connect', (data) ->
    console.log 'connected'
    console.log data

    doSomething = ->
      console.log 'test'
      setTimeout(doSomething, 1000)
      socket.emit 'wtf',
        foo: 'baz'

    setTimeout(doSomething, 1000)

  game.start()