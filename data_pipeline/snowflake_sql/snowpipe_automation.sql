-------------------------------------------------------------Event-Notification-Pipe----------------------------------------------------

--CREATE SNOWPIPE THAT RECOGNISES CSV THAT ARE INGESTED FROM EXTERNAL STAGE AND COPIES THE DATA INTO EXISTING TABLE

--The AUTO_INGEST=true parameter specifies to read 
--- event notifications sent from an S3 bucket to an SQS queue when new data is ready to load.

-- Table 1
CREATE PIPE IF NOT EXISTS stock_pipe 
AUTO_INGEST = TRUE 
AS
COPY INTO raw_stock_data
FROM @realtime_stage/table_name(mention your table name)
FILE_FORMAT = complaints_parquet_format
PATTERN = '.*\\.parquet'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

-- Table 2
CREATE PIPE IF NOT EXISTS stock_pipe 
AUTO_INGEST = TRUE 
AS
COPY INTO raw_stock_data
FROM @realtime_stage/channel_table
FILE_FORMAT = complaints_parquet_format
PATTERN = '.*\\.parquet'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

-- Table 3
CREATE PIPE IF NOT EXISTS stock_pipe 
AUTO_INGEST = TRUE 
AS
COPY INTO raw_stock_data
FROM @realtime_stage/location_table
FILE_FORMAT = complaints_parquet_format
PATTERN = '.*\\.parquet'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

--------------------------------------------
-- add mulitiple table as per your requirements
--------------------------------------------

-- then move to event-notifications
-- CONNECT S3 EVENT → SNOWPIPE
-- Go to AWS S3 → Open bucket → Go to Properties → Event notifications → Create event → Event type: PUT → Prefix: raw/trades/ → Destination: SNS topic (Snowflake gives this)

-- Snowflake gives SNS topic ARN → Run: DESC PIPE stock_pipe; → You will get: → notification_channel: arn:aws:sns:... → copy and paste

SHOW PIPES;

----------------------------------------------------------PIPEREFRESH-----------------------------------------------------------------

-- Client loaded data in AWS you need to execute following command to referesh the folder that data will be loaded automatically
ALTER PIPE RETAIL_SNOWPIPE_DEMOGRAPHIC refresh;
ALTER PIPE  RETAIL_SNOWPIPE_CAMPAIGN_DESC refresh;
ALTER PIPE  RETAIL_SNOWPIPE_CAMPAIGN refresh;
ALTER PIPE  RETAIL_SNOWPIPE_PRODUCT refresh;
ALTER PIPE  RETAIL_SNOWPIPE_COUPON refresh;
ALTER PIPE  RETAIL_SNOWPIPE_COUPON_REDEMPT refresh;
ALTER PIPE  RETAIL_SNOWPIPE_TRANSACTION refresh;

---------------------------------------------------------Count-Star(*)------------------------------------------------------------------

-- Execute the following command when you want to check number of transaction
-- when you want to check table number one by one.
SELECT COUNT(*) FROM demographic_RAW;
SELECT COUNT(*) FROM CAMPAIGN_DESC_RAW;
SELECT COUNT(*) FROM CAMPAIGN_RAW;
SELECT COUNT(*) FROM PRODUCT_RAW;
SELECT COUNT(*) FROM COUPON_RAW;
SELECT COUNT(*) FROM COUPON_REDEMPT_RAW;
SELECT COUNT(*) FROM TRANSACTION_RAW;


-- When you want to count all the table together 
SELECT COUNT(*) FROM demographic_RAW
UNION ALL
SELECT COUNT(*) FROM CAMPAIGN_DESC_RAW
UNION ALL
SELECT COUNT(*) FROM CAMPAIGN_RAW
UNION ALL
SELECT COUNT(*) FROM PRODUCT_RAW
UNION ALL
SELECT COUNT(*) FROM COUPON_RAW
UNION ALL
SELECT COUNT(*) FROM COUPON_REDEMPT_RAW
UNION ALL
SELECT COUNT(*) FROM TRANSACTION_RAW;

--------------------------------------------------------Snowpipe-Stauts-----------------------------------------------------------------

-- This very very important code p
-- Following are some snowpipe command which will help you to check snowpipe status 
-- count command count the no of rows but this command very very important which help to verify the count.

select SYSTEM$PIPE_STATUS('RETAIL_SNOWPIPE_TRANSACTION'); -- Enter the snowpipe full name  

select * from table(information_schema.copy_history(table_name=>'TRANSACTION_RAW', start_time=>
dateadd(hours, -1, current_timestamp())));
-- you enter snowfake folder name you created

-----------------------------------------------------To-Check-The-All-Data--------------------------------------------------------------

-- To check all table data we execute this code
SELECT * FROM demographic_RAW;
SELECT * FROM CAMPAIGN_DESC_RAW;
SELECT * FROM CAMPAIGN_RAW;
SELECT * FROM PRODUCT_RAW;
SELECT * FROM COUPON_RAW;
SELECT * FROM COUPON_REDEMPT_RAW;
SELECT * FROM TRANSACTION_RAW;
