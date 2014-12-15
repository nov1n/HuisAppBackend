mongoose = require 'mongoose'

userSchema = new mongoose.Schema
  first_name:
    type: String
  last_name:
    type: String
  mail:
    type: String
  house_id:
    type: mongoose.Schema.Types.ObjectId

userSchema.methods.test = ->
  console.log 'Function called on user model'

User = mongoose.model('User', userSchema);

module.exports = User
