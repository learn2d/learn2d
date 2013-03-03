http = require 'http'

express = require 'express'
Game = require './game'

app = express()
server = http.createServer(app)
io = require('socket.io').listen(server)

game = new Game()

app.get '/', (req, res) ->
  if req.host is 'www.learn2d.com'
    res.redirect(301, 'http://learn2d.com');
  else
    res.render 'render',
      title: 'Learn2D'

app.get '/play', (req, res) ->
  res.render 'render',
    title: 'Learn2D'

app.configure ->
  app.use express.methodOverride()
  app.use express.bodyParser()
  app.use app.router
  app.use express.static __dirname + '/../client/'
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

  # ejs views
  app.set 'view engine', 'ejs'
  app.set 'view options'
    layout: false

io.sockets.on 'connection', (socket) ->
  game.addClient socket


server.listen 3000