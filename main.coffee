express = require 'express'
mongoose = require 'mongoose'
errorHandler = require 'errorhandler'
bodyParser = require 'body-parser'
logger = require 'morgan'
_ = require 'underscore'
app = express()

#
# Configuration
#

config = require './config/config'

app.use logger('dev')
app.use express.static('public')
app.use require('express-uncapitalize')() # Normalizes url by lowercasing it

# Parse application/x-www-form-urlencoded
app.use bodyParser.urlencoded {extended: true}

# Parse application/json
app.use bodyParser.json()

if config.env == 'development'
  app.use(errorHandler()) # Returns full error stack trace to the client

# Allow cross-domain requests
app.all '*', (req, res, next) ->
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
  res.header('Access-Control-Allow-Headers', 'Content-Type')
  next()

#
# Routes
#

users = require './routes/users'
houses = require './routes/houses'

app.get '/api', (req, res) ->
  res.json 'API is running...'
app.use('/api/users', users) # Mount the user route to /users
app.use('/api/houses', houses)

#
# Server
#

app.listen config.port, ->
  console.log "Express server listening on port #{config.port} in #{config.env} mode"

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
# Export app variable for tests
#

module.exports = app;