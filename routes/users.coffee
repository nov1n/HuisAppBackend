express = require 'express'

router = express.Router()

router.route('/')
.get (req, res) ->
  res.json('It works!')


router.route '/:name'
.get (req, res) ->
  res.json(req.params.name)

module.exports = router