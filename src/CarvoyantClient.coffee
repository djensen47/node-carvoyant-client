request = require("request")

url = "https://dash.carvoyant.com/api"

class CarvoyantClient
  constructor: (@apiKey, @securityToken) ->

  _get: (uri, query, cb) ->
    cb = query if query? and not cb? and typeof query is "function"
    options =
      auth:
        user: @apiKey
        password: @securityToken
        sendImmediately: false
      qs: query
      json: true
    request.get url+uri, options, (err, res, body) ->
      # console.log err
      # console.log res
      # console.log body
      cb(err, res)


  listVehicles: (options, cb) ->
    {} = options
    @_get "/vehicle", {}, (err, res) ->
      cb(err, res.body)

  getVehicle: (id, options, cb) ->
    {} = options
    @_get "/vehicle/#{id}", (err, res) ->
      cb(err, res.body)
  
  listTrips: (id, options, cb) ->
    @_get "/vehicle/#{id}/trip", (err, res) ->
      cb(err, res.body)

  getTrip: (vid, tid, options, cb) ->
    @_get "/vehicle/#{vid}/trip/#{tid}", (err, res) ->
      cb(err, res.body)

  # Not implemented
  rawData: (id, options, cb) ->
    cb(null, null)
 
  # Not implemented
  createVehicle: () ->
    cb(null, null)

module.exports = CarvoyantClient
