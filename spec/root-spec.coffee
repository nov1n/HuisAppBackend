request = require 'supertest'
express = require 'express'
app = require('../main').getApp;

describe "GET /", ->
  it "respond with json", (done) ->
    request app
    .get "/"
    .expect "Content-Type", /json/
    .expect 200, done