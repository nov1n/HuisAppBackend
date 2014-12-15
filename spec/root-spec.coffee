request = require 'request'
config = require('../config/config')

baseURI = config.localhost + config.port

describe 'API route', ->
  it "should respond with 'API is running...'", (done) ->
    request "#{baseURI}/api", (err, res, body) ->
      expect(body).toEqual('\"API is running...\"')
      done()

