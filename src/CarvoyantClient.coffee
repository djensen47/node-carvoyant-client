request = require("superagent")

url = "https://dash.carvoyant.com/api"

class CarvoyantClient
  constructor: (@apiKey, @securityToken) ->

  _get: (uri, cb) ->
    request.get(url+uri)
      .auth(@apiKey, @securityToken)
      .end (err, res) ->
        cb(err, res)


  listVehicles: (options, cb) ->
    {} = options
    this._get "/vehicle", (err, res) ->
      cb(err, res.body)

  getVehicle: (id, options, cb) ->
    {} = options
    this._get "/vehicle/#{id}", (err, res) ->
      cb(err, res.body)

  createVehicle: () -> 

  listTrips: (id, options, cb) ->

  rawData: (id, options, cb) ->
      



module.exports = CarvoyantClient
