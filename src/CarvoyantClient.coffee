request = require("request")

url = "https://dash.carvoyant.com/api"

class CarvoyantClient
  constructor: (@apiKey, @securityToken) ->

  _get: (uri, cb) ->
    options =
      auth:
        user: @apiKey
        password: @securityToken
        sendImmediately: false
      json: true
    request.get url+uri, options, (err, res, body) ->
      cb(err, res)


  listVehicles: (options, cb) ->
    {} = options
    this._get "/vehicle", (err, res) ->
      cb(err, res.body)

  getVehicle: (id, options, cb) ->
    {} = options
    this._get "/vehicle/#{id}", (err, res) ->
      cb(err, res.body)
  
  # Not implemented
  createVehicle: () ->
    cb(null, null)

  # Not implemented
  listTrips: (id, options, cb) ->
    cb(null, null)

  # Not implemented
  rawData: (id, options, cb) ->
    cb(null, null)
      



module.exports = CarvoyantClient
