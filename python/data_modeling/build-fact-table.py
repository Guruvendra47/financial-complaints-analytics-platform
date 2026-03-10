
# IMPORT LIBRARIES

# pandas is used for data manipulation
import pandas as pd

# location where processed data files are stored
data_path = "C:/Users/guruv/Downloads/Data/Project/financial-risk-analytics-platform/data/processed/"

# load the cleaned complaints dataset
complaints = pd.read_csv(data_path + "complaints_processed.csv")

# load dimension tables
dim_product = pd.read_csv(data_path + "dim_product.csv")
dim_company = pd.read_csv(data_path + "dim_company.csv")
dim_location = pd.read_csv(data_path + "dim_location.csv")
dim_channel = pd.read_csv(data_path + "dim_channel.csv")

print("All datasets loaded successfully")
print("Complaints dataset shape:", complaints.shape)

# merge complaints dataset with product dimension
# this replaces product name with product_id
complaints = complaints.merge(
    dim_product,
    left_on="product",
    right_on="product_name",
    how="left"
)

print("Product mapping complete")

# merge company dimension
complaints = complaints.merge(
    dim_company,
    left_on="company",
    right_on="company_name",
    how="left"
)

print("Company mapping complete")

# merge location dimension
complaints = complaints.merge(
    dim_location,
    left_on="state",
    right_on="state_code",
    how="left"
)

print("Location mapping complete")

# merge submission channel dimension
complaints = complaints.merge(
    dim_channel,
    left_on="submitted_via",
    right_on="channel_name",
    how="left"
)

print("Channel mapping complete")

# select only the fields needed for the fact table
fact_complaints = complaints[
    [
        "complaint_id",
        "product_id",
        "company_id",
        "location_id",
        "channel_id",
        "date_received",
        "issue",
        "timely_response",
        "consumer_disputed"
    ]
]

print("Fact table preview:")
print(fact_complaints.head())

# save fact table
fact_complaints.to_csv(data_path + "fact_complaints.csv", index=False)

print("Fact table saved successfully")

# check
print("Fact table shape:", fact_complaints.shape)