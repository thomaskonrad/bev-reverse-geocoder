BEV Address Data Reverse Geocoder
=================================

This services converts coordinates into an array of address data sets released by the Bundesamt für Eich- und
Vermessungswesen (BEV) in Austria. You can see the service in action and an API description
(here)[http://bev-reverse-geocoder.osm.thomaskonrad.at/].

Data: © Österreichisches Adressregister, Stichtagsdaten vom 15.07.2015

Example
-------

The request

```
http://bev-reverse-geocoder.osm.thomaskonrad.at/reverse-geocode/json?lat=16.37236&lon=48.20808&distance=50&limit=3&epsg=4326
```

gives the following result:

```
{
   "status":"ok",
   "results":[
      {
         "distance":9.909445594,
         "house_name":"",
         "house_number":"2",
         "municipality":"Wien",
         "lon":48.208111,
         "street":"Stephansplatz ",
         "postcode":"1010",
         "lat":16.372235
      },
      {
         "distance":13.943139329,
         "house_name":"",
         "house_number":"3A",
         "municipality":"Wien",
         "lon":48.20809,
         "street":"Stephansplatz ",
         "postcode":"1010",
         "lat":16.372547
      },
      {
         "distance":18.571775123,
         "house_name":"",
         "house_number":"1",
         "municipality":"Wien",
         "lon":48.208116,
         "street":"Stock-im-Eisen-Platz ",
         "postcode":"1010",
         "lat":16.372116
      }
   ],
   "copyright":"\u00a9 \u00d6sterreichisches Adressregister, Stichtagsdaten vom 15.07.2015"
}
```
