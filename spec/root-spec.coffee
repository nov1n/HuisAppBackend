request = require 'request'
config = require('../config/config')

baseURI = config.localhost + config.port

describe 'Routes testing', ->
  it "should respond with hello world", (done) ->
    request "#{baseURI}/", (err, res, body) ->
      expect(body).toEqual('{"a":"5"}')
      done()

