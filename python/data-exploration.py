"""
Exploratory Data Analysis (EDA) typically checks:

1. dataset size
2. column structure
3. sample records
4. missing values
5. duplicates
6. data types
"""


# import the pandas library
# pandas is used for reading and analyzing data files like CSV
import pandas as pd


# define dataset path
file_path = "C:/Users/guruv/Downloads/Data/Project/financial-risk-analytics-platform/data/processed/complaints_processed.csv"


# read first 100k rows becasue never load the full dataset during exploration
df = pd.read_csv(file_path, nrows=100000, low_memory=False)


# print the size of the dataset
# shape shows (rows, columns)
print("Dataset shape (rows, columns):")
print(df.shape)

# print the column names
# this helps us understand the dataset structure
print("\nColumn names:")
print(df.columns)

# Unique products
print("\nUnique Products:")
print(df["product"].unique())

# Number of companies
print("\nTotal Unique Companies:")
print(df["company"].nunique())

# Submission channels
print("\nSubmission Methods:")
print(df["submitted_via"].unique())

# States
print("\nUnique States:")
print(df["state"].unique())

# dataset info
print("\nDataset information:")
print(df.info())

# preview records
# show the first 5 rows of the dataset
# head() is useful to preview data quickly
print("\nFirst 5 rows:")
print(df.head())


# check if there are missing values in each column
# isnull() finds missing values
# sum() counts how many missing values exist
print("\nMissing values per column:")
print(df.isnull().sum())


# check if there are duplicate rows
# duplicated() finds rows that appear more than once
# sum() counts how many duplicates exist
print("\nDuplicate rows:")
print(df.duplicated().sum())

# basic statistics
print("\nBasic statistics:")
print(df.describe(include="all"))