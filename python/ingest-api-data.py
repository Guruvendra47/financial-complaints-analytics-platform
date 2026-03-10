# Import datetime module
# This is used to create a dynamic file name based on today's date
# In real pipelines this is called "data partitioning"
from datetime import datetime

# Import requests library
# This library allows Python to send HTTP requests to APIs
# Our script will use it to pull complaint data from the CFPB API
import requests

# Import pandas library
# Pandas is used to convert raw JSON data into a structured table format (DataFrame)
import pandas as pd

# Generate today's date in YYYY_MM_DD format
# Example: 2026_03_06
today = datetime.today().strftime("%Y_%m_%d")

# Define the output file path
# This will save the dataset inside the RAW DATA LAYER of our project
# Each run will create a new file with today's date
filename = f"C:/Users/guruv/Downloads/Data/Project/financial-risk-analytics-platform/data/raw/complaints_{today}.csv"

# Define batch size
# The API only allows a limited number of records per request
# We will download records in small chunks (batches)
batch_size = 10000

# Define the total number of records we want to download
# This allows us to scale ingestion easily
# Later we can increase this to millions of records
total_records = 5000000

# Create an empty list to store all records collected from each batch
# This acts as a temporary storage before converting the data into a dataframe
all_records = []

# Start the batch ingestion loop
# This loop controls pagination of the API
# Example batches:
# 0–99
# 100–199
# 200–299
# etc.
for start in range(0, total_records, batch_size):

    # Print the batch starting position
    # This helps track pipeline progress in the terminal logs
    print(f"Downloading records starting from {start}")

    # Build the API URL dynamically
    # The 'size' parameter controls how many records per request
    # The 'from' parameter controls the offset (starting record)
    url = f"https://www.consumerfinance.gov/data-research/consumer-complaints/search/api/v1/?size={batch_size}&from={start}"

    # Retry logic
    # If the API fails, the script will retry up to 3 times
    # This protects pipelines from temporary network issues
    for attempt in range(3):

        try:

            # Send GET request to the API
            response = requests.get(url)

            # Check if the HTTP request was successful
            # Status code 200 means success
            if response.status_code != 200:
                raise Exception("API request failed")

            # Convert the API response into JSON format
            data = response.json()

            # If request succeeded, exit retry loop
            break

        except Exception as e:

            # Print retry message
            print(f"Attempt {attempt + 1} failed. Retrying...")

            # If the third attempt fails, skip this batch
            if attempt == 2:

                print("Skipping this batch due to repeated failures")
                # Set data to None so pipeline knows to skip
                data = None

    # If API failed after retries, skip this batch
    if data is None:
        continue

    # Extract complaint records from API response
    # The CFPB API stores records inside hits → hits
    complaints = data["hits"]["hits"]

    # Convert JSON objects into Python dictionaries
    # Each complaint record is stored under "_source"
    records = [item["_source"] for item in complaints]

    # Add the batch records to the master list
    # This accumulates all records across batches
    all_records.extend(records)

    # Print success message for batch
    print(f"Batch starting at {start} downloaded successfully")

# Convert all collected records into a pandas DataFrame
# This transforms the raw JSON list into a structured table
df = pd.DataFrame(all_records)

# Inspect schema returned by API
print("Columns in dataset:", df.columns)

# Select only the columns required for analytics
# Real data pipelines remove unnecessary columns to optimize storage
columns_needed = [
    "complaint_id",
    "date_received",
    "product",
    "issue",
    "sub_issue",
    "company",
    "state",
    "submitted_via",
    "company_response",
    "timely",
    "consumer_disputed"
]

df = df[columns_needed]

# Print total records downloaded
# This is useful for validating ingestion success
print("Total records downloaded:", len(df))

# Save the dataframe to CSV in the raw data layer
# This file will later be loaded into the warehouse
df.to_csv(filename, index=False)

# Print confirmation message
print("Raw data saved successfully")

# Display first few rows of the dataset
# Helps verify that the data structure is correct
print(df.head())