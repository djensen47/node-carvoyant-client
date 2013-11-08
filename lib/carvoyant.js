(function() {
  var CarvoyantClient, CarvoyantRequest, dataKeys, request, sortOrder, url;

  request = require("request");

  url = "https://dash.carvoyant.com/api";

  dataKeys = {
    DIAGNOSTIC_TROUBLE_CODES: "GEN_DTC",
    VOLTAGE: "GEN_VOLTAGE",
    TRIP_MILEAGE: "GEN_TRIP_MILEALGE",
    ODOMETER: "GEN_ODOMETER",
    GPS_LOCATION: "GEN_WAYPOINT",
    HEADING: "GEN_HEADING",
    ENGINE_SPEED: "GEN_RPM",
    FUEL_LEVEL: "GEN_FUELLEVEL",
    FUEL_RATE: "GEN_FUELRATE",
    ENGINE_TEMP: "GEN_ENGINE_COOLANT_TEMP",
    MAX_SPEED: "GEN_SPEED"
  };

  sortOrder = {
    ASCENDING: "asc",
    DESCENDING: "desc"
  };

  CarvoyantRequest = (function() {
    function CarvoyantRequest(apiKey, securityToken, method, uri) {
      this.apiKey = apiKey;
      this.securityToken = securityToken;
      this.method = method;
      this.uri = uri;
      this.query = {};
      this;
    }

    CarvoyantRequest.prototype.get = function(uri) {
      this.uri = uri;
      this.method = "GET";
      return this;
    };

    CarvoyantRequest.prototype.post = function(post) {
      this.post = post;
      this.method = "POST";
      return this;
    };

    CarvoyantRequest.prototype.dataKey = function(keyName) {
      this.query["key"] = keyName;
      return this;
    };

    CarvoyantRequest.prototype.mostRecentOnly = function(bool) {
      this.query["mostRecentOnly"] = bool;
      return this;
    };

    CarvoyantRequest.prototype.sortOrder = function(sortOrder) {
      this.query["sortOrder"] = sortOrder;
      return this;
    };

    CarvoyantRequest.prototype.searchLimit = function(limit) {
      this.query["searchLimit"] = limit;
      return this;
    };

    CarvoyantRequest.prototype.searchOffset = function(offset) {
      this.query["searchOffset"] = offset;
      return this;
    };

    CarvoyantRequest.prototype.exec = function(cb) {
      var options;
      options = {
        uri: url + this.uri,
        method: this.method,
        auth: {
          user: this.apiKey,
          password: this.securityToken,
          sendImmediately: false
        },
        qs: this.query,
        json: true
      };
      return request(options, function(err, res, body) {
        return cb(err, body);
      });
    };

    return CarvoyantRequest;

  })();

  CarvoyantClient = (function() {
    function CarvoyantClient(apiKey, securityToken) {
      this.apiKey = apiKey;
      this.securityToken = securityToken;
    }

    CarvoyantClient.prototype.request = function() {
      return new CarvoyantRequest(this.apiKey, this.securityToken);
    };

    CarvoyantClient.prototype.listVehicles = function() {
      return this.request().get("/vehicle");
    };

    CarvoyantClient.prototype.getVehicle = function(id) {
      return this.request().get("/vehicle/" + id);
    };

    CarvoyantClient.prototype.listTrips = function(id) {
      return this.request().get("/vehicle/" + id + "/trip");
    };

    CarvoyantClient.prototype.getTrip = function(vid, tid) {
      return this.request().get("/vehicle/" + vid + "/trip/" + tid);
    };

    CarvoyantClient.prototype.rawData = function(vid) {
      return this.request().get("/vehicle/" + vid + "/data");
    };

    CarvoyantClient.prototype.createVehicle = function() {
      return cb(null, null);
    };

    return CarvoyantClient;

  })();

  module.exports = CarvoyantClient;

  module.exports.dataKeys = dataKeys;

  module.exports.sortOrder = sortOrder;

}).call(this);
