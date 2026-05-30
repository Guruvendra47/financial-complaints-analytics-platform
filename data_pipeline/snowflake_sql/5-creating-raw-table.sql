----------------------------------------------------------
-- Creating Raw table
-----------------------------------------------------------

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


