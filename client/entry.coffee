define [
  'game'
], (game) ->
  document.addEventListener 'mousedown', ->
    console.log 'test'
    false

  game.init()

  console.log('init?')