mongoose = require 'mongoose'

UserSchema = new mongoose.Schema
  first_name:
    type: String
    index: true
  last_name:
    type: String
    index: true
  house_id:
    type: mongoose.Schema.Types.ObjectId
    index: true


Item = mongoose.model('User', UserSchema);

module.exports =
  User: User