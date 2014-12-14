express = require 'express'
http = require 'http'
mongoose = require 'mongoose'
logger = require 'morgan'
app = express()

#
# Configuration
#

config = require './config/config'

router = express.Router() # Not used
app.use(logger('dev'));

port = config.port
if process.argv.indexOf('-p') >= 0
  port = process.argv[process.argv.indexOf('-p') + 1]
app.set('port', port)

## Development only

if process.env.NODE_ENV == 'development'
  app.use(errorhandler()) # Returns full error stack trace to the client

#
# Allow cross-domain requests
#

app.all '*', (req, res, next) ->
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
  res.header('Access-Control-Allow-Headers', 'Content-Type')
  next()

#
# Server
#

http.Server(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get 'port'} in #{app.settings.env} mode"

#
# Database
#

User  = require('./models/user').User
House = require('./models/house').House

mongoose.connect "mongodb://localhost/#{config.db.dev.name}"
db = mongoose.connection
db.on 'error', (err) ->
  console.error("Could not connect to MongoDB: %s", err)
db.once 'open', ->
  console.log("Connected to: mongodb://localhost/#{config.db.dev.name}")


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

module.exports = app;