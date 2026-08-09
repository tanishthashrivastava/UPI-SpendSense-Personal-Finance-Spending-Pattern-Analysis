# UPI SpendSense: Personal Finance & Spending Pattern Analysis

## Project Overview

UPI SpendSense is an end-to-end data analytics project focused on analyzing personal finance and UPI transaction behavior in an Indian fintech context.

The project uses a synthetic but realistically structured dataset of 1,200 users and approximately 100,000–170,000 transactions. The data is designed to simulate different user spending behaviors, transaction categories, time patterns, payment statuses, and user personas.

The objective is to transform raw transaction data into meaningful financial insights and identify unusual spending behavior.

## Key Objectives

* Analyze UPI spending patterns across transaction categories
* Compare spending behavior across different user personas
* Identify weekday vs weekend spending differences
* Analyze transaction behavior across different times of the day
* Track monthly spending trends
* Identify high-value merchants and spending categories
* Detect unusual or potentially anomalous transactions based on user-level behavior
* Build an interactive Power BI dashboard for business insights

## Dataset

The synthetic dataset was generated using Python to represent a realistic Indian UPI transaction environment.

### Users Dataset

* 1,200 users
* 6 user personas
* Multiple Indian cities
* Android and iOS device types
* Multiple simulated banking institutions

### Transaction Dataset

* Approximately 100,000–170,000 transactions
* 12 months of transaction history
* Variable transaction frequency based on user persona
* Multiple transaction categories and merchants
* Successful, failed, and pending payment statuses

## User Personas

The dataset includes the following user segments:

1. Student
2. Working Professional
3. Family User
4. Budget Conscious
5. Frequent Traveler
6. High Spender

Each persona follows different transaction frequency and spending patterns to enable meaningful user segmentation and behavioral analysis.

## Transaction Categories

* Food & Dining
* Grocery
* Shopping
* Transportation
* Travel
* Healthcare
* Entertainment
* Bills & Utilities
* Mobile Recharge
* Education
* P2P Transfer

## Tools and Technologies

* Python
* Pandas
* NumPy
* Matplotlib
* SQL
* Power BI
* GitHub

## Current Analysis

The current notebook includes:

* Synthetic dataset generation
* Data quality checks
* Missing value analysis
* Duplicate validation
* Data type validation
* Overall business KPIs
* Category-wise spending analysis
* Monthly spending trends
* Persona-based spending analysis
* Weekday vs weekend behavior analysis
* Time-of-day transaction analysis
* Merchant spending analysis
* Transaction volume vs spending value analysis

## Key Business Questions

* Which categories contribute the highest transaction value?
* Which user personas demonstrate the highest average transaction value?
* How does spending differ between weekdays and weekends?
* Which merchants receive the highest transaction value?
* At what time of day do users transact most frequently?
* How do different user personas contribute to monthly spending trends?
* Which transactions deviate significantly from a user's normal spending behavior?

## Project Status

🚧 In Progress

### Completed

* [x] Synthetic dataset generation
* [x] Data cleaning and validation
* [x] Exploratory data analysis
* [x] Spending behavior visualizations

### Next Steps

* [ ] Advanced user-level anomaly detection
* [ ] SQL business analysis
* [ ] Power BI dashboard development
* [ ] Risk scoring
* [ ] Final business recommendations

## Repository Structure

```text
upi-spendsense-analysis/
│
├── data/
│   ├── users.csv
│   └── upi_transactions_final.csv
│
├── notebooks/
│   └── UPI_SpendSense_Analysis.ipynb
│
├── sql/
│   └── analysis_queries.sql
│
├── powerbi/
│   └── UPI_SpendSense_Dashboard.pbix
│
└── README.md
```

## Author

Tanishtha Shrivastava

Aspiring Data Analyst | Python | SQL | Power BI | Data Analytics
