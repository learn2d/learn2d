define [
  'game'
], (Game) ->
  document.addEventListener 'mousedown', ->
    false

  game = new Game()

  game.init()