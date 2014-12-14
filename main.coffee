express = require 'express'
mongoose = require 'mongoose'
errorhandler = require 'errorhandler'
logger = require 'morgan'
app = express()

#
# Configuration
#

config = require './config/config'

app.use logger('dev')
app.use express.static('public')
app.use require('express-uncapitalize')() # Normalizes url by lowercasing it

if config.env == 'development'
  app.use(errorhandler()) # Returns full error stack trace to the client

# Allow cross-domain requests
app.all '*', (req, res, next) ->
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
  res.header('Access-Control-Allow-Headers', 'Content-Type')
  next()

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
# Routes
#

app.get '/', (req, res) ->
  res.json { a: '5'}

app.get '/coffee/:beep', (req, res) ->
  res.json req.params.beep

app.get '/beed', (req, res) ->
  res.json { a: 6 }

#
# Export app variable for tests
#

module.exports = app;