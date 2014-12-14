express = require 'express'

router = express.Router()

router.route('/')
.get (req, res) ->
  res.json('It works!')


router.route '/:id'
.get (req, res) ->
  res.json(req.params.id)

module.exports = router