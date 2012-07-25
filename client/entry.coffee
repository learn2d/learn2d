define [
  'game',
  'cs!resource-loader'
], (Game, ResourceLoader) ->
  document.addEventListener 'mousedown', ->
    false

  resourceLoader = new ResourceLoader()
  game = new Game()

  game.init(resourceLoader)