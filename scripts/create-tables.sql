-- Drop the tables first if it exists. This allows copy-pasting this entire file in any case.
DROP TABLE IF EXISTS bev_date;
DROP TABLE IF EXISTS bev_addresses;
DROP TABLE IF EXISTS bev_localities;

-- Create the date table.
CREATE TABLE bev_date
(
  date DATE NOT NULL
);

-- Create the address table.
CREATE TABLE bev_addresses
(
  municipality character varying NOT NULL,
  postcode character varying NOT NULL,
  street character varying NOT NULL,
  house_number character varying,
  house_name character varying,
  address_type character varying,
  point geography(Point,4326) NOT NULL
);

-- Create an index on the 'point' column to speed up reverse geocoding.
CREATE INDEX bev_addresses_point ON bev_addresses USING GIST (point);

-- Other indices.
CREATE INDEX bev_addresses_municipality ON bev_addresses(municipality);
CREATE INDEX bev_addresses_street ON bev_addresses(street);
CREATE INDEX bev_addresses_house_number ON bev_addresses(house_number);

-- Create the table with all localities.
CREATE TABLE bev_localities
(
  gkz character varying NOT NULL,
  okz character varying NOT NULL,
  name character varying NOT NULL,
  CONSTRAINT bev_localities_pk PRIMARY KEY (okz)
);

-- Create an index on the name column so that SELECTs on the name are faster.
CREATE INDEX bev_localities_name ON bev_localities(name);