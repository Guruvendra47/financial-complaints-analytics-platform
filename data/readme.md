# Data Architecture & Pipelines

This directory manages raw ingestion feeds, staging files, and dimension mapping data for the financial complaints pipeline.

---

## Directory Overview

```text
data/
├── raw/             # Unprocessed, immutable landing zone for incoming payloads
├── staged/          # Intermediate transformed outputs ready for warehouse loading
└── data_modeling/   # Star-schema dimension lookup tables
```

---

## Dataset Definitions

| File / Folder | Format | Description |
| :--- | :--- | :--- |
| `raw/` | JSON / CSV | Source payload dumps prior to cleaning and structural validation |
| `staged/` | Parquet / CSV | Processed records post-deduplication, casting, and null-handling |
| `data_modeling/` | CSV | Dimension seed data (`dim-channel`, `dim-company`, `dim-location`, `dim-product`) |

---

## Data Pipeline Lifecycle

1. **Landing Zone (`raw/`)**: Ingestion scripts pull raw consumer financial complaint payloads directly from external API endpoints or streaming source topics.
2. **Transform & Clean (`staged/`)**: Spark jobs process raw records, enforce schema constraints, handle missing values, and output partitioned files.
3. **Dimensional Join (`data_modeling/`)**: Staged facts are joined against reference dimension keys to populate downstream star-schema entities.
4. **Analytics Storage**: Transformed datasets load into storage layers for query execution and BI reporting.