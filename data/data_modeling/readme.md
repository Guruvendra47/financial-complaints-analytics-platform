# Data Modeling

This directory contains the dimensional lookup datasets used to model entity relationships within the financial complaints processing pipeline.

---

## Directory Structure

```text
data_modeling/
├── dim-channel.csv
├── dim-company.csv
├── dim-location.csv
└── dim-product.csv
```

---

## Schema Reference

### `dim-channel.csv`
Defines intake methods and communication channels.

| Column Name | Type | Key | Description |
| :--- | :--- | :--- | :--- |
| `channel_id` | INT | PK | Unique identifier for the channel |
| `submitted_via` | VARCHAR | — | Submission mechanism (Web, Referral, Phone, etc.) |

### `dim-company.csv`
Contains financial institutions referenced across complaint records.

| Column Name | Type | Key | Description |
| :--- | :--- | :--- | :--- |
| `company_id` | INT | PK | Unique identifier for the company |
| `company_name` | VARCHAR | — | Legal entity name |

### `dim-location.csv`
Geographic dimension mapping origin attributes.

| Column Name | Type | Key | Description |
| :--- | :--- | :--- | :--- |
| `location_id` | INT | PK | Unique location record identifier |
| `state` | VARCHAR | — | Two-letter state postal abbreviation |
| `zip_code` | VARCHAR | — | Origin zip code |

### `dim-product.csv`
Hierarchical product categorization.

| Column Name | Type | Key | Description |
| :--- | :--- | :--- | :--- |
| `product_id` | INT | PK | Unique product identifier |
| `product_name` | VARCHAR | — | Primary financial product category |
| `sub_product` | VARCHAR | — | Secondary product classification |

---

## Data Pipeline Integration

1. **Ingestion**: CSV files are loaded during database seed routines or pipeline setup.
2. **Transformation**: The pipeline joins incoming raw complaint event logs against these dimensions using surrogate keys.
3. **Analytics**: Exports populated star-schema tables to data warehouses for Power BI reporting and downstream modeling.