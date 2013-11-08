var CarvoyantClient = require("../lib/carvoyant"),
    sortOrder = require("../lib/carvoyant").sortOrder,
    dataKeys = require("../lib/carvoyant").dataKeys;


var carvoyant = new CarvoyantClient(process.env.CARVOYANT_KEY, process.env.CARVOYANT_TOKEN);

// List vehicles
carvoyant.listVehicles().exec(function(err, data){
  console.log(data);
  var vid = data.vehicle[0].vehicleId;

  // Raw data access
  carvoyant
    .rawData(vid)
    .sortOrder(sortOrder.DESCENDING)
    .dataKey(dataKeys.GPS_LOCATION)
    .searchLimit(10)
    .searchOffset(11)
    .exec(function(err, data) {
      console.log(data);
    });


  // Get a vehicle
  carvoyant.getVehicle(vid).exec(function(err, data) { console.log(data) });

  // List trips
  carvoyant.listTrips(vid).exec(function(err, data){
    console.log(data);

    // Get a trip
    carvoyant.getTrip(vid, data.trip[0].id).exec(function(err, data){
      console.log(data); 
    });
  });
  
});


