/*
CREATE SCHEMA IF NOT EXISTS minio.userdata
WITH (location = 's3a://tintin/userdata/');

CREATE SCHEMA IF NOT EXISTS minioiceberg.exampleiceberg
WITH (location = 's3a://tintin/iceberg/userdata/');

DROP SCHEMA minio.userdata;

CREATE TABLE IF NOT EXISTS minio.userdata.userdata (
  registration_dttm timestamp,
  id int,
  first_name VARCHAR,
  last_name VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  ip_address VARCHAR,
  cc VARCHAR,
  country VARCHAR,
  birthdate VARCHAR,
  salary double,
  title VARCHAR,
  comments VARCHAR
)
WITH (
  external_location = 's3a://tintin/userdata/',
  format = 'PARQUET'
);

DROP TABLE minio.userdata.userdata;

insert into minio.userdata.userdata (first_name) values ('Darren')

select * from minio.userdata.userdata;
*/

--IcebergFormat

CREATE SCHEMA IF NOT EXISTS minioiceberg.exampleiceberg
WITH (location = 's3a://tintin/iceberg/');

CREATE TABLE IF NOT EXISTS minioiceberg.exampleiceberg.userdata (
  registration_dttm timestamp,
  id int,
  first_name VARCHAR,
  last_name VARCHAR,
  email VARCHAR,
  gender VARCHAR,
  ip_address VARCHAR,
  cc VARCHAR,
  country VARCHAR,
  birthdate VARCHAR,
  salary double,
  title VARCHAR,
  comments VARCHAR
)
WITH (
  location = 's3a://tintin/iceberg/userdata/',
  format = 'PARQUET'
);

select * from minioiceberg.exampleiceberg.userdata;

insert into minioiceberg.exampleiceberg.userdata (first_name) values ('Darren')