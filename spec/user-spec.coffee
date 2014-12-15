mongoose = require 'mongoose'
User = require '../models/user'

describe "User model", ->
  user = new User {
    first_name: 'Jack'
    last_name: 'the Ripper'
    house_id: null
    not_existing_property: 1
  }

  it 'should have the fields first_name, last_name and house_id', ->
    expect(user.first_name).toBe 'Jack'
    expect(user.last_name).toBe 'the Ripper'
    expect(user.house_id).toBeDefined()

  it 'should not contain properties that do not exist', ->
    expect(user.not_existing_property).toBeUndefined()
