express = require 'express'
User = require '../models/user'
_ = require('underscore')._

router = express.Router()

#
# GET all users
#

router.route('/')
.get (req, res) ->
  return User.find (err, users) ->
    if !err
      res.json users
    else
      return console.log err

#
# GET a single user
#

router.route('/:id')
.get (req, res) ->
  idToFind = req.params.id
  return User.findById idToFind, (err, users) ->
    if !err
      res.json users
    else
      return console.log err

#
# CREATE a user
#

# TODO: add validation code
router.route('/new')
.post (req, res) ->
  user = new User
    first_name: req.body.first_name
    last_name: req.body.last_name
    mail: req.body.mail
  user.save (err) ->
    if !err
      console.log('Created successfully')
    else
      res.status(400).json 'Could not create user'
  res.json(user)

#
# UPDATE a user
#

# TODO: add validation code
router.route('/:id')
.put (req, res) ->
  IDtoUpdate = req.params.id
  User.findByIdAndUpdate IDtoUpdate,
    first_name: req.body.first_name
    last_name: req.body.last_name
    mail: req.body.mail,
    (err, user) ->
      if _.isEmpty(user)
        if err
          console.log(err)
        res.status(404).json 'User not updated.'
      else
        res.status(200).json 'User updated successfully'

#
# DELETE a user
#

router.route('/:id')
.delete (req, res) ->
  IDtoDelete = req.params.id
  User.findByIdAndRemove IDtoDelete, (err, user) ->
    if _.isEmpty(user)
      if err
        console.log(err)
      res.status(404).json 'User not deleted.'
    else
      res.status(200).json 'User deleted successfully'

module.exports = router