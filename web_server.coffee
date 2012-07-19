express = require 'express'
browserify = require 'browserify'

app = express.createServer()

app.get '/', (req, res) ->
    res.render 'index',
        title: 'My Site'

app.get '/test', (req, res) ->
    res.render 'test',
        title: 'My Site'

app.configure ->
    app.use express.methodOverride()
    app.use express.bodyParser()
    app.use app.router
    app.use express.static __dirname + '/public'
    app.use express.errorHandler
        dumpExceptions: true
        showStack: true

    # browserify
    bundle = browserify
        entry: __dirname + '/assets/entry.coffee'
        watch: true
        debug: true
        require: {}

    app.use bundle

    # ejs views
    app.set 'view engine', 'ejs'
    app.set 'view options'
        layout: false

app.listen 3000