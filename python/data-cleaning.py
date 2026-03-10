
# Import pandas library

import pandas as pd

# Load dataset
raw_file = "C:/Users/guruv/Downloads/Data/Project/financial-risk-analytics-platform/data/raw/complaints.csv"

df = pd.read_csv(raw_file, low_memory=False)

# Clean column names
df.columns = (
    df.columns
    .str.lower()
    .str.replace(" ", "_")
    .str.replace("-", "_")
    .str.replace("?", "")
    )

# Display dataset info
print(df.info())

# Row statistics
print("Total rows before cleaning:", len(df))
print("Unique complaint IDs:", df["complaint_id"].nunique())

# Remove duplicate records
df = df.drop_duplicates(subset="complaint_id")

# Convert date columns
df["date_received"] = pd.to_datetime(df["date_received"], errors="coerce")

# handle missing values 
df["timely_response"] = df["timely_response"].fillna("Unknown")
df["consumer_disputed"] = df["consumer_disputed"].fillna("Unknown")
# df["sub_issue"] = df["sub_issue"].fillna("Unknown")

# Standardize company names
df["company"] = df["company"].str.upper()

# remove invalid rows
df = df.dropna(subset=["complaint_id", "date_received"])

# sort data
df = df.sort_values(by="date_received")

# final dataset stats
print("Total rows after cleaning:", len(df))


# Save cleaned dataset
# path where file will be saved
processed_file = "../data/processed/complaints_processed.csv"

# where data is converted into csv file
df.to_csv(processed_file, index=False)

print("Processed data saved successfully")
