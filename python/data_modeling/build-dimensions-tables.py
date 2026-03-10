# import the pandas library
# pandas is used for reading and analyzing data files like CSV
import pandas as pd

#
# STEP 1: Load a small portion of the dataset

# file path 
file_path = "C:/Users/guruv/Downloads/Data/Project/financial-risk-analytics-platform/data/raw/complaints.csv"


# read file
df = pd.read_csv(file_path)

print("Dataset loaded successfully")

# df.shape is used calculate rows and columns
print(df.shape)


# creating product table

products = df["product"].dropna().unique()

dim_product = pd.DataFrame(products, columns=["product_name"])

dim_product["product_id"] = range(1, len(dim_product) + 1)

dim_product = dim_product[["product_id", "product_name"]]

print("\nProduct Dimension:")
print(dim_product.head())


# creating company table

companies = df["company"].dropna().unique()

dim_company = pd.DataFrame(companies, columns=["company_name"])

dim_company["company_id"] = range(1, len(dim_company) + 1)

dim_company = dim_company[["company_id", "company_name"]]

print("\nCompany Dimension:")
print(dim_company.head())


# creating location table

states = df["state"].dropna().unique()

dim_location = pd.DataFrame(states, columns=["state_code"])

dim_location["location_id"] = range(1, len(dim_location) + 1)

dim_location = dim_location[["location_id", "state_code"]]

print("\nLocation Dimension:")
print(dim_location.head())


# creating channel table

channels = df["submitted_via"].dropna().unique()

dim_channel = pd.DataFrame(channels, columns=["channel_name"])

dim_channel["channel_id"] = range(1, len(dim_channel) + 1)

dim_channel = dim_channel[["channel_id", "channel_name"]]

print("\nSubmission Channel Dimension:")
print(dim_channel.head())


# saving files

# saving file path
output_path = f"C:/Users/guruv/Downloads/Data/Project/financial-risk-analytics-platform/data/processed/"

# creating csv files
dim_product.to_csv(output_path + "dim_product.csv", index=False)
dim_company.to_csv(output_path + "dim_company.csv", index=False)
dim_location.to_csv(output_path + "dim_location.csv", index=False)
dim_channel.to_csv(output_path + "dim_channel.csv", index=False)

print("\nDimension tables saved successfully.")