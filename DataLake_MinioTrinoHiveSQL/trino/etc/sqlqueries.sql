--CREATE SCHEMA IF NOT EXISTS minio.sales
--WITH (location = 's3a://sales/darren/');

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