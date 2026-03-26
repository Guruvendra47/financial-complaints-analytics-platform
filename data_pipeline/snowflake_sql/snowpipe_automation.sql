-------------------------------------------------------------Event-Notification-Pipe----------------------------------------------------

--CREATE SNOWPIPE THAT RECOGNISES CSV THAT ARE INGESTED FROM EXTERNAL STAGE AND COPIES THE DATA INTO EXISTING TABLE

--The AUTO_INGEST=true parameter specifies to read 
--- event notifications sent from an S3 bucket to an SQS queue when new data is ready to load.

-- Table 1
CREATE PIPE IF NOT EXISTS stock_pipe_customer
AUTO_INGEST = TRUE 
AS
COPY INTO customer_table -- mention table name in which you want to copy the data
FROM @realtime_stage/customer --stage/s3 bucket folder name
FILE_FORMAT = complaints_parquet_format
PATTERN = '.*\\.parquet'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

-- Table 2
CREATE PIPE IF NOT EXISTS stock_pipe_channel
AUTO_INGEST = TRUE 
AS
COPY INTO channel_table
FROM @realtime_stage/channel
FILE_FORMAT = complaints_parquet_format
PATTERN = '.*\\.parquet'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

-- Table 3
CREATE PIPE IF NOT EXISTS stock_pipe_location
AUTO_INGEST = TRUE 
AS
COPY INTO location_table
FROM @realtime_stage/location
FILE_FORMAT = complaints_parquet_format
PATTERN = '.*\\.parquet'
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

--------------------------------------------
-- add mulitiple table as per your requirements
--------------------------------------------

-- then move to event-notifications
-- CONNECT S3 EVENT → SNOWPIPE
-- Go to AWS S3 → Open bucket → Go to Properties → Event notifications → Create event → Event type: PUT → Prefix: raw/trades/ → Destination: SNS topic (Snowflake gives this)

-- Snowflake gives SNS topic ARN → Run: DESC PIPE stock_pipe; or show pipes; → You will get: → notification_channel: arn:aws:sns:... → copy and paste

SHOW PIPES;

----------------------------------------------------------PIPEREFRESH-----------------------------------------------------------------

-- Client loaded data in AWS you need to execute following command to referesh the folder that data will be loaded automatically
ALTER PIPE stock_pipe_customer refresh;
ALTER PIPE  stock_pipe_channel refresh;
ALTER PIPE  stock_pipe_location refresh;

---------------------------------------------------------Count-Star(*)------------------------------------------------------------------

-- Execute the following command when you want to check number of transaction
-- when you want to check table number one by one.
SELECT COUNT(*) FROM cusotmer_table;
SELECT COUNT(*) FROM channel_table;
SELECT COUNT(*) FROM location_table;

-- When you want to count all the table together 
SELECT COUNT(*) FROM customer_table
UNION ALL
SELECT COUNT(*) FROM channel_table
UNION ALL
SELECT COUNT(*) FROM location_table

--------------------------------------------------------Snowpipe-status-----------------------------------------------------------------

-- This very very important code p
-- Following are some snowpipe command which will help you to check snowpipe status 
-- count command count the no of rows but this command very very important which help to verify the count.

select SYSTEM$PIPE_STATUS('ENTER YOUR SNOWPIPE NAME'); -- Enter the snowpipe full name  

select * 
from table 
  (information_schema.copy_history(table_name=>'TRANSACTION_RAW', 
  start_time=> dateadd(hours, 
  -1, 
  current_timestamp())));
-- you enter snowfake folder name you created

-----------------------------------------------------To-Check-The-All-Data--------------------------------------------------------------

-- To check all table data we execute this code
SELECT * FROM customer_table;
SELECT * FROM channel_table;
SELECT * FROM location_table;

