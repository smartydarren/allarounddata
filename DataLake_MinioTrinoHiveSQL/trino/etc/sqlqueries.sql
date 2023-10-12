--CREATE SCHEMA IF NOT EXISTS minio.sales
--WITH (location = 's3a://sales/darren1/');

-- DROP SCHEMA minio.sales

--CREATE TABLE IF NOT EXISTS minio.sales.sales_parquet (
--  productcategoryname VARCHAR,
--  productsubcategoryname VARCHAR,
--  productname VARCHAR,
--  country VARCHAR,
--  salesamount DOUBLE,
--  orderdate timestamp
--)
--WITH (
--  external_location = 's3a://sales/darren/',
--  format = 'PARQUET'
--);

-- DROP TABLE minio.sales.sales_parquet;

select * from minio.sales.sales_parquet;

---------------------------------------------

/*
CREATE SCHEMA IF NOT EXISTS minio.sales1
WITH (location = 's3a://sales/darren1/');

 DROP SCHEMA minio.sales1

CREATE TABLE IF NOT EXISTS minio.sales1.userdata1 (
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
  external_location = 's3a://sales/darren1/',
  format = 'PARQUET'
);

DROP TABLE minio.sales1.userdata1;

select * from minio.sales1.userdata1;


*/