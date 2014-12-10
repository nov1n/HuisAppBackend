mongoose = require 'mongoose'

HouseSchema = new mongoose.Schema
  name:
    type: String
    index: true

Item = mongoose.model('House', HouseSchema);

module.exports =
  House: House