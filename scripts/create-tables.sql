-- Drop the table first if it exists. This allows copy-pasting this entire file in any case.
DROP TABLE IF EXISTS bev_addresses;

-- Create the table.
CREATE TABLE bev_addresses
(
  municipality character varying NOT NULL,
  postcode character varying NOT NULL,
  street character varying NOT NULL,
  house_number character varying,
  house_name character varying,
  point geography(Point,4326) NOT NULL
);

-- Create an index on the 'point' column to speed up reverse geocoding.
CREATE INDEX bev_addresses_point ON bev_addresses USING GIST (point);
