express = require 'express'
Game = require './Game'

app = express.createServer()

game = new Game()

io = require('socket.io').listen(3001)

io.sockets.on 'connection', (socket) ->
  game.addClient socket

app.get '/', (req, res) ->
  res.render 'render',
    title: 'Learn2D'

app.configure ->
  app.use express.methodOverride()
  app.use express.bodyParser()
  app.use app.router
  app.use express.static __dirname + '/client'
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

  # ejs views
  app.set 'view engine', 'ejs'
  app.set 'view options'
    layout: false

app.listen 3000