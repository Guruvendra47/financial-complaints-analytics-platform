----------------------------------------------------------
-- Creating Raw table
-----------------------------------------------------------

-- Use Database and Schema
USE DATABASE FINANCE_ANALYTICS;
USE SCHEMA COMPLAINTS;

-- Create File Format
CREATE FILE FORMAT IF NOT EXISTS complaints_csv_format
TYPE = 'CSV'
COMPRESSION = 'AUTO'
FIELD_DELIMITER = ','
FIELD_OPTIONALLY_ENCLOSED_BY='"'
RECORD_DELIMITER = '\n'
SKIP_HEADER = 1
SKIP_BLANK_LINES = TRUE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE;

-- Create Raw Table
-- Using STRING as data type is a classic strategy when you are building what data engineers call a Landing Table (or "Raw" table).
-- do not adding primary key or any other CONSTRAINT because this raw data.
CREATE OR REPLACE TABLE complaints_raw (
date_received STRING,
product STRING,
sub_product STRING,
issue STRING,
sub_issue STRING,
consumer_complaint_narrative STRING,
company_public_response STRING,
company STRING,
state STRING,
zip_code STRING,
tags STRING,
consumer_consent_provided STRING,
submitted_via STRING,
date_sent_to_company STRING,
company_response_to_consumer STRING,
timely_response STRING,
consumer_disputed STRING,
complaint_id STRING
);

-- Load Data from S3
-- CSV file
COPY INTO complaints_raw
FROM @complaints_stage
FILE_FORMAT = complaints_csv_format
PATTERN = '.*\\.csv'
-- adding continue which skip bad rows check before adding this
ON_ERROR = CONTINUE;

-- PARQUET file
COPY INTO raw_stock_data
FROM @realtime_stage
FILE_FORMAT = complaints_parquet_format
PATTERN = '.*\\.parquet'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

-- Verify the Load
SELECT COUNT(*) FROM complaints_raw;
