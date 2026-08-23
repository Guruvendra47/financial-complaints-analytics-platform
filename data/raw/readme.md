# Raw Data Landing Zone

This directory contains raw source files prior to cleanup, transformation, and ingestion.

---

## Storage & Setup Instructions

The dataset is not included in this repository due to its large size.

To populate this directory locally or prepare files for cloud ingestion:

1. Download the Consumer Complaint Database from the [CFPB Data Portal](https://www.consumerfinance.gov/data-research/consumer-complaints/).
2. Place the file in this directory as `complaints.csv`.
3. If running cloud ETL, upload the uncompressed file to your designated AWS S3 staging bucket.

---

## Expected Input Schema

| Field Name | Format | Description |
| :--- | :--- | :--- |
| `Date received` | `YYYY-MM-DD` | Date complaint was submitted |
| `Product` | String | High-level financial product classification |
| `Sub-product` | String | Sub-category of the product |
| `Issue` | String | Primary issue topic |
| `Company` | String | Financial institution named in complaint |
| `State` | String | Consumer state postal code |
| `ZIP code` | String | Consumer postal code |
| `Submitted via` | String | Submission channel (Web, Phone, Referral, etc.) |
| `Timely response?` | String | Timeliness indicator (`Yes`/`No`) |
