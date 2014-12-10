mongoose = require 'mongoose'

houseSchema = new mongoose.Schema
  name:
    type: String
    index: true

House = mongoose.model('House', houseSchema);

module.exports =
  House: House