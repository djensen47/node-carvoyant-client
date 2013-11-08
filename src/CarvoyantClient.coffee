request = require("request")

url = "https://dash.carvoyant.com/api"

dataKeys =
  DIAGNOSTIC_TROUBLE_CODES: "GEN_DTC"
  VOLTAGE: "GEN_VOLTAGE"
  TRIP_MILEAGE: "GEN_TRIP_MILEALGE"
  ODOMETER: "GEN_ODOMETER"
  GPS_LOCATION: "GEN_WAYPOINT"
  HEADING: "GEN_HEADING"
  ENGINE_SPEED: "GEN_RPM"
  FUEL_LEVEL: "GEN_FUELLEVEL"
  FUEL_RATE: "GEN_FUELRATE"
  ENGINE_TEMPERATURE: "GEN_ENGINE_COOLANT_TEMP"
  MAX_SPEED: "GEN_SPEED"

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
      cb(err, body)


class CarvoyantClient
  constructor: (@apiKey, @securityToken) ->

  request: () ->
    new CarvoyantRequest(@apiKey, @securityToken)

  listVehicles: () ->
    @request().get("/vehicle")

  getVehicle: (id) ->
    @request().get("/vehicle/#{id}")
  
  listTrips: (id) ->
    @request().get("/vehicle/#{id}/trip")

  getTrip: (vid, tid) ->
    @request().get("/vehicle/#{vid}/trip/#{tid}")

  rawData: (id) ->
    @request().get("/vehicle/#{vid}/data")
 
  # Not implemented
  createVehicle: () ->
    cb(null, null)

module.exports = CarvoyantClient
module.exports.dataKeys = dataKeys
