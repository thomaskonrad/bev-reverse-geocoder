BEV Address Data Reverse Geocoder
=================================

This services converts coordinates into an array of address data sets released by the Bundesamt für Eich- und
Vermessungswesen (BEV) in Austria. You can see the service in action and an API description
[here](https://bev-reverse-geocoder.thomaskonrad.at/).

Data: © Österreichisches Adressregister 2017, N 23806/2017 (Stichtagsdaten vom 02.10.2016)

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
   "copyright":"\u00a9 \u00d6sterreichisches Adressregister 2017, N 23806/2017 (Stichtagsdaten vom {{ date }})",
   "address_date": "2016-10-02",
   "results":[
      {
         "address_type:"street",
         "municipality":"Wien",
         "locality": "Innere Stadt",
         "postcode":"1010",
         "street":"Stephansplatz",
         "house_name":"",
         "house_number":"2",
         "lat":48.208111,
         "lon":16.372235,
         "distance":9.909445594,
         "municipality_has_ambiguous_addresses": false
      },
      {
         "address_type:"street",
         "municipality":"Wien",
         "locality": "Innere Stadt",
         "postcode":"1010",
         "street":"Stephansplatz",
         "house_number":"3A",
         "house_name":"",
         "lat":16.372547,
         "lon":48.20809,
         "distance":13.943139329,
         "municipality_has_ambiguous_addresses": false
      },
      {
         "address_type:"street",
         "municipality":"Wien",
         "locality": "Innere Stadt",
         "postcode":"1010",
         "street":"Stock-im-Eisen-Platz",
         "house_number":"1",
         "house_name":"",
         "lat":16.372116,
         "lon":48.208116,
         "distance":18.571775123,
         "municipality_has_ambiguous_addresses": false
      }
   ]
}
```

Requirements
------------

This Python Django project requires Django 1.10.*.

Importing the Addresses into PostgreSQL
---------------------------------------

In order to import the data into the database, execute the ``scripts/create-tables.sql`` script on your PostgreSQL
database instance first. This script deletes all relevant tables (if they exist) and then creates them.

To download and convert the data into a usable format, use the
[convert-bev-address-data-python](https://github.com/thomaskonrad/convert-bev-address-data-python) script of the user
_scubbx_. Before you run the Python script, install the modules ``gdal`` and ``argparse`` by issuing the command
``pip install gdal argparse``. The script downloads the data from BEV and converts it into EPSG 4326 by issuing the
following command:

    python convert-addresses.py -epsg 4326

This outputs a file called ``bev_addressesEPSG4326.csv``. We can now use this file to import the address data into our
PostgreSQL database:

    python scripts/import-bev-data.py -d gis -f /path/to/bev_addressesEPSG4326.csv -D "2016-10-02"

With the ``-D`` parameter you can specify the date the data was released in the format ``YYYY-MM-DD``. This is important
for the correct copyright statement when using the data in OpenStreetMap.

Using the Data in OpenStreetMap
-------------------------------

OpenStreetMap has the [official permission to use the data](https://wiki.openstreetmap.org/wiki/WikiProject_Austria/%C3%96sterreichisches_Adressregister).
Keep in mind, however, that the data source must be mentioned in the object or changeset source.
