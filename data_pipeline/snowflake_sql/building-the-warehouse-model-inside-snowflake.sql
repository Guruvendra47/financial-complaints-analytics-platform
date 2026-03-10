
---------------------------------------------------------------------------
 -- Creating Fact and Dimension Tables
--------------------------------------------------------------------------

-- Use Database and Schema
USE DATABASE FINANCE_ANALYTICS;
USE SCHEMA COMPLAINTS;

-- Create Dimension Tables --

-- Product dimension
CREATE OR REPLACE TABLE dim_product AS
SELECT
    ROW_NUMBER() OVER (ORDER BY product) AS product_id,
    product AS product_name
FROM (
    SELECT DISTINCT product
    FROM complaints_raw
    WHERE product IS NOT NULL
);

-- Company dimension
CREATE OR REPLACE TABLE dim_company AS
SELECT
    ROW_NUMBER() OVER (ORDER BY company) AS company_id,
    company AS company_name
FROM (
    SELECT DISTINCT company
    FROM complaints_raw
    WHERE company IS NOT NULL
);

-- Location dimension
CREATE OR REPLACE TABLE dim_location AS
SELECT
    ROW_NUMBER() OVER (ORDER BY state) AS location_id,
    state AS state_code
FROM (
    SELECT DISTINCT state
    FROM complaints_raw
    WHERE state IS NOT NULL
);

-- Channel dimension
CREATE OR REPLACE TABLE dim_channel AS
SELECT
    ROW_NUMBER() OVER (ORDER BY submitted_via) AS channel_id,
    submitted_via AS channel_name
FROM (
    SELECT DISTINCT submitted_via
    FROM complaints_raw
    WHERE submitted_via IS NOT NULL
);

-- Verify Dimensions
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(*) FROM dim_company;
SELECT COUNT(*) FROM dim_location;
SELECT COUNT(*) FROM dim_channel;


-- Create Fact Table
CREATE OR REPLACE TABLE fact_complaints AS
SELECT
    r.complaint_id,
    p.product_id,
    c.company_id,
    l.location_id,
    ch.channel_id,
    r.date_received,
    r.issue,
    r.timely_response,
    r.consumer_disputed
FROM complaints_raw r
LEFT JOIN dim_product p
    ON r.product = p.product_name
LEFT JOIN dim_company c
    ON r.company = c.company_name
LEFT JOIN dim_location l
    ON r.state = l.state_code
LEFT JOIN dim_channel ch
    ON r.submitted_via = ch.channel_name;