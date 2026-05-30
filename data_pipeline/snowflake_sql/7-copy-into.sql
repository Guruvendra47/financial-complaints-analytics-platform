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
