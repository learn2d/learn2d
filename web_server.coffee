express = require 'express'

app = express.createServer()

app.get '/', (req, res) ->
    res.render 'index',
        title: 'Learn2D'

app.get '/render', (req, res) ->
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