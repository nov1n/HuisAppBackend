express = require 'express'
http = require 'http'
livereload = require 'express-livereload'
mongoose = require 'mongoose'
app = express()

#
# Configuration
#

DB_NAME = 'HUISAPP_DB'
DB_USER = 'dev'
DB_PWD  = 'urNmPZ7nARE2NB6eLLR'

app.configure -> # use -p 8080 to run server on port 8080
  port = 3000
  if process.argv.indexOf('-p') >= 0
    port = process.argv[process.argv.indexOf('-p') + 1]

  app.set 'port', port
  app.use express.logger('dev')
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler()

#
# Allow cross-domain requests
#

app.all('*', (req, res, next) ->
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
  res.header('Access-Control-Allow-Headers', 'Content-Type')
  next()
)

#
# Server
#

http.Server(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get 'port'} in #{app.settings.env} mode"

#
# Database
#

mongoose.connect "mongodb://localhost/#{DB_NAME}"
db = mongoose.connection;
db.on('error', (err) -> console.error("Could not connect to MongoDB: %s", err))
db.once('open', ->

)


#
# Routes
#

app.get '/', (req, res) ->
  res.json { a: '5'}

app.get '/coffee', (req, res) ->
  res.json { a: 6 }

app.get '/beed', (req, res) ->
  res.json { a: 6 }

#
# Export app variable for tests
#

module.exports.getApp = app;