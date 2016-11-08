BEV Address Data Reverse Geocoder
=================================

This services converts coordinates into an array of address data sets released by the Bundesamt für Eich- und
Vermessungswesen (BEV) in Austria. You can see the service in action and an API description
[here](https://bev-reverse-geocoder.thomaskonrad.at/).

Data: © Österreichisches Adressregister, Stichtagsdaten vom 02.10.2016

Example
-------

The request

```
https://bev-reverse-geocoder.thomaskonrad.at/reverse-geocode/json?lat=48.20808&lon=16.37236&distance=50&limit=3&epsg=4326
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
         "lon":16.372235,
         "street":"Stephansplatz ",
         "postcode":"1010",
         "lat":48.208111,
      },
      {
         "distance":13.943139329,
         "house_name":"",
         "house_number":"3A",
         "municipality":"Wien",
         "lat":16.372547,
         "street":"Stephansplatz ",
         "postcode":"1010",
         "lon":48.20809
      },
      {
         "distance":18.571775123,
         "house_name":"",
         "house_number":"1",
         "municipality":"Wien",
         "lat":16.372116,
         "street":"Stock-im-Eisen-Platz ",
         "postcode":"1010",
         "lon":48.208116
      }
   ],
   "copyright":"\u00a9 \u00d6sterreichisches Adressregister, Stichtagsdaten vom 02.10.2016"
}
```
