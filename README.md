# Financial Complaints Analytics Platform

## Project Overview

This project demonstrates an **end-to-end data analytics platform** built to analyze consumer financial complaints. The pipeline integrates **cloud storage, ETL processing, data warehousing, and business intelligence visualization** to transform raw complaint data into actionable insights.

The platform ingests complaint data, processes and models it in a **Snowflake data warehouse**, and delivers interactive analytics through **Power BI dashboards**.

The goal of this project is to simulate a **real-world analytics solution used by financial institutions and consulting firms**.

---

# Business Problem

Financial institutions receive thousands of consumer complaints across different financial products and services. These complaints contain valuable insights about customer dissatisfaction, operational issues, and regulatory risks.

However, raw complaint data is often large and difficult to analyze directly. Organizations require a centralized analytics platform that can process complaint data and generate actionable insights for business and regulatory decision-making.

---

# Business Requirements

The objective of this project is to design an analytics platform that enables stakeholders to monitor and analyze financial complaints effectively.

Key requirements include:

* Build a scalable data pipeline to ingest complaint data
* Transform raw data into analytics-ready datasets
* Design a dimensional data model for reporting
* Provide interactive dashboards for business users
* Identify trends in complaint volume over time
* Analyze complaints by product, company, issue, and location
* Enable drill-down analysis for specific companies

---

# Business Questions

The platform helps answer the following questions:

* Which financial products receive the most consumer complaints?
* Which companies generate the highest complaint volumes?
* What are the most common complaint issues reported by consumers?
* How have complaint trends changed over time?
* Which states report the highest complaint volumes?
* Are companies responding to complaints in a timely manner?

---

# Architecture

The data pipeline follows this architecture:

CFPB Consumer Complaint Dataset → AWS S3 (Storage) → Matillion ETL (Transformation) → Snowflake (Warehouse) → Power BI (Dashboard)

<img width="773" height="724" alt="Architecture-1" src="https://github.com/user-attachments/assets/4ac233e8-f6f6-4a71-a754-708779df1c07" />

This architecture reflects a modern cloud analytics stack used in industry.

---

# Technology Stack

| Layer               | Tools Used      |
| ------------------- | --------------- |
| Data Storage        | AWS S3          |
| Data Transformation | Matillion ETL   |
| Data Warehouse      | Snowflake       |
| Data Modeling       | SQL             |
| Data Exploration    | Python (Pandas) |
| Visualization       | Power BI        |

---

# Data Source

Dataset used in this project:

**CFPB Consumer Complaint Database**

Source:
https://www.consumerfinance.gov/data-research/consumer-complaints/

Note:
The dataset is not included in this repository due to its large size.

---

# Data Warehouse Model

A **star schema** was implemented in Snowflake.

### Fact Table

`FACT_COMPLAINTS`

Contains complaint records including:

* complaint_id
* date_received
* product_id
* company_id
* location_id
* channel_id
* issue
* timely_response
* consumer_disputed

### Dimension Tables

* `DIM_PRODUCT`
* `DIM_COMPANY`
* `DIM_LOCATION`
* `DIM_CHANNEL`

These tables provide descriptive attributes used for analysis.

---

# Data Pipeline

The pipeline performs the following steps:

1. Raw complaint data stored in **AWS S3**
2. **Matillion orchestration job** loads data from S3
3. **Matillion transformation job** cleans and structures data
4. Data loaded into **Snowflake fact and dimension tables**
5. **Power BI connects to Snowflake** to build dashboards

---

# Power BI Dashboard

The dashboard provides interactive analysis across multiple perspectives.

## Executive Overview

<img width="1919" height="1017" alt="executive-dashboard" src="https://github.com/user-attachments/assets/3589c775-0dc2-47b0-af66-bcbf3126b7d0" />

This page provides a high-level summary including total complaints, response rates, complaint trends, and top companies receiving complaints.

---

## Complaint Trends

<img width="1919" height="1018" alt="complaint-trends" src="https://github.com/user-attachments/assets/3f22a66b-dac2-4c2c-834b-f086ce630e3c" />

This page analyzes complaint trends over time and identifies patterns across products and states.

---

## Company Analysis

<img width="1919" height="1018" alt="company-analysis" src="https://github.com/user-attachments/assets/9e72905d-3408-414b-8ef9-80941b99587c" />

This page allows users to explore complaints for a specific company and analyze trends, issues, and product distribution.

---

## Product & Issue Analysis

<img width="1919" height="1017" alt="product-issue-analysis" src="https://github.com/user-attachments/assets/fbb20390-065a-4146-a987-c758a641b846" />

This page provides root-cause insights by analyzing the relationship between financial products and complaint issues.

---

## Repository Structure

```
financial-complaints-analytics-platform
│
├── architecture
│   └── pipeline_architecture.png
│
├── data
│   └── dataset_source.md
│
├── python
│   ├── data_exploration.py
│   ├── data_modeling.py
│   └── build_dimension_tables.py
│
├── data_pipeline
│   ├── matillion_jobs
│   │   ├── orchestration_job.json
│   │   └── transformation_job.json
│   │
│   └── snowflake_sql
│       ├── create_tables.sql
│       ├── dimension_tables.sql
│       └── fact_complaints.sql
│
├── powerbi_dashboard
│   ├── financial_complaints_dashboard.pbix
│   │
│   └── dashboard_screenshots
│       ├── executive_overview.png
│       ├── complaint_trends.png
│       ├── company_analysis.png
│       └── product_issue_analysis.png
│
└── documentation
    ├── data_model.md
    └── dashboard_explanation.md
```


---

# Key Insights

This platform enables analysts to identify:

* financial products generating the highest complaints
* recurring complaint issues across companies
* geographic complaint distribution
* trends in complaint volume over time

---

# Author

**Guruvendra Singh**

Data Analytics | Data Engineering | Business Intelligence
