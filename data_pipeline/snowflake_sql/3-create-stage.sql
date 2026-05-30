-- Create External Stage
CREATE STAGE complaints_stage
URL='s3://financial-complaints-data-lake/raw/'
STORAGE_INTEGRATION = s3_int;

-- Check File Visibility
LIST @complaints_stage;
