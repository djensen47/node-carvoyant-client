request = require("request")

url = "https://dash.carvoyant.com/api"

class CarvoyantRequest
  constructor: (@apiKey, @securityToken, @method, @uri) ->
    @query = {}
    this

  get: (@uri) ->
    @method = "GET"
    this

  post: (@post) ->
    @method = "POST"
    this

  param: (key, value) ->
    @query[key] = value
    this

  key: (keyName) ->
    @param("key", keyName)
    this

  mostRecentOnly: (bool) ->
    @param("mostRecentOnly", bool)
    this

  sortOrder: (sortOrder) ->
    @param("sortOrder", sortOrder)
    this

  exec: (cb) ->
    options =
      uri: url+@uri
      method: @method
      auth:
        user: @apiKey
        password: @securityToken
        sendImmediately: false
      qs: @query
      json: true
    request options, (err, res, body) ->
      cb(err, res)


class CarvoyantClient
  constructor: (@apiKey, @securityToken) ->

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

  # rawData
  # =======
  # *Parameters*
  #  - *id* _String_ id of the vehicle
  #  - *options* _Object_ parameters for the API call
  #  - *cb* _Function_ callback when the request is complete
  #    - *err*
  #    - *res* 
  rawData: (id, options, cb) ->
    @_get "/vehicle/#{vid}/data", (err, res) ->
      cb(null, null)
 
  # Not implemented
  createVehicle: () ->
    cb(null, null)

module.exports = CarvoyantClient
