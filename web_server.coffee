express = require 'express'

app = express.createServer()

io = require('socket.io').listen(3001)

io.sockets.on 'connection', (socket) ->
  socket.on 'init', (data) ->
  socket.emit 'init', ->
    player:
      x: 400
      y: 400
    players: []
    levelName: 'test'

  socket.on 'move', (data) ->
    socket.volatile.broadcast.emit 'update', ->
  socket.on 'wtf', (data) ->
    console.log 'wtf'
    console.log data

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