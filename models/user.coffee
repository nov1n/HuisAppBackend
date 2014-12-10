mongoose = require 'mongoose'

userSchema = new mongoose.Schema
  first_name:
    type: String
    index: true
  last_name:
    type: String
    index: true
  house_id:
    type: mongoose.Schema.Types.ObjectId
    index: true

userSchema.methods.test = ->
  console.log 'Function called on user model'

User = mongoose.model('User', userSchema);

module.exports =
  User: User