define [
  'game',
  'cs!resource-loader',
  'json',
  'json!Data.json'
], () ->
  window.Level = require 'json!Data.json'

  Game = require 'game'
  ResourceLoader = require 'cs!resource-loader'

  document.addEventListener 'mousedown', ->
    false

  canvas = document.getElementById("myCanvas");
  context = canvas.getContext("2d");

  resourceLoader = new ResourceLoader()
  game = new Game(resourceLoader, canvas, context)

  game.init(resourceLoader)

  require ['json!Data.json'], (data) ->
    console.log data