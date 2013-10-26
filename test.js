require('coffee-script');

var Client = require ('./lib/CarvoyantClient');

var client = new Client('d797ff54-7ab5-48b3-becb-e00cf1c18c26','5370a42a-4df0-4586-953e-4ee09d0e7307');

console.log(client.getVehicles().body);
console.log("here");
