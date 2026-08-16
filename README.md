# UPI SpendSense: Personal Finance & UPI Spending Pattern Analysis

> An end-to-end data analytics project focused on understanding UPI spending behavior, user segmentation, transaction patterns, and anomalous financial activity in a realistic Indian fintech context.

---

## 📌 Project Overview

**UPI SpendSense** is an end-to-end Data Analytics project designed to analyze personal finance and UPI transaction behavior in an Indian fintech environment.

The project uses a **synthetic but realistically structured UPI transaction dataset** generated using Python. The dataset simulates user demographics, spending personas, transaction categories, merchants, payment behavior, time-based transaction patterns, and transaction risk.

The objective was to transform raw transaction data into actionable business insights using **Python, SQL, and Power BI**, while also identifying unusual transaction behavior that could indicate potential financial risk.

The project follows a complete analytics workflow:

**Data Generation → Data Validation → EDA → Behavioral Analysis → Anomaly Detection → Risk Analysis → SQL Business Analysis → Power BI Dashboard → Business Insights**

---

## 🎯 Business Objectives

The project focuses on answering practical business questions that a fintech or digital payments company may encounter:

- How are users spending through UPI?
- Which categories contribute the highest transaction value?
- Which user personas spend the most?
- How does spending differ between weekdays and weekends?
- When are users most active during the day?
- How does spending change month-over-month?
- Which categories contribute the highest anomalous spending?
- How much transaction value is associated with high-risk activity?
- Which transactions require further investigation?

---

# 📊 Dataset

The dataset was **synthetically generated using Python** to simulate a realistic Indian UPI ecosystem.

Synthetic data was intentionally used to avoid exposing real financial or personally identifiable information while still enabling realistic behavioral analysis.

### User Dataset

The simulated user base includes:

- 1,200 users
- 6 user personas
- Multiple Indian cities
- Android and iOS devices
- Simulated banking institutions
- Persona-based transaction behavior

### Transaction Dataset

The final transaction dataset contains approximately **150K+ UPI transactions** across 12 months.

The dataset includes:

- Transaction ID
- User ID
- Transaction date
- Transaction amount
- Merchant
- Category
- Payment status
- Payment method
- User persona
- City
- Device type
- Time of day
- Day type
- Anomaly indicators
- Anomaly score
- Risk level

---

# 👥 User Personas

Six simulated user personas were created to represent different spending behaviors:

1. **Student**
2. **Working Professional**
3. **Family User**
4. **Budget Conscious**
5. **Frequent Traveler**
6. **High Spender**

Each persona follows different transaction-frequency and spending patterns, allowing meaningful behavioral segmentation.

---

# 🛍️ Transaction Categories

The dataset covers common Indian consumer spending categories such as:

- Food & Dining
- Grocery
- Shopping
- Transportation
- Travel
- Healthcare
- Entertainment
- Bills & Utilities
- Mobile Recharge
- Education
- P2P Transfer

---

# 🛠️ Tools & Technologies

| Technology | Purpose |
|---|---|
| **Python** | Data generation, cleaning, EDA & anomaly analysis |
| **Pandas** | Data manipulation and analysis |
| **NumPy** | Numerical operations |
| **Matplotlib** | Data visualization |
| **SQL Server** | Business analysis and advanced SQL querying |
| **Power BI** | Interactive dashboards and KPI reporting |
| **GitHub** | Version control and project documentation |

---

# 🔍 Analytical Workflow

## 1. Synthetic Data Generation

Python was used to generate realistic UPI transaction data with controlled behavioral patterns.

The generation process incorporated:

- User personas
- Transaction frequency
- Spending ranges
- Categories
- Merchants
- Dates and timestamps
- Payment statuses
- Time-of-day behavior
- Indian cities
- Device types

This allowed the dataset to contain meaningful patterns suitable for business analysis.

---

## 2. Data Cleaning & Validation

The generated data was validated before analysis.

Key checks included:

- Missing-value analysis
- Duplicate validation
- Data-type validation
- Date validation
- Transaction amount validation
- Category consistency
- Payment-status validation
- User-level transaction validation

---

# 📈 Exploratory Data Analysis

Python-based EDA was used to understand overall transaction behavior.

Analysis included:

- Overall transaction KPIs
- Category-wise spending
- Monthly spending trends
- User persona analysis
- Weekday vs weekend behavior
- Time-of-day transaction activity
- Merchant-level spending
- Transaction volume vs transaction value
- User spending behavior

The analysis helped identify the major drivers of UPI transaction activity and spending.

---

# 🚨 Anomaly Detection & Risk Analysis

A key objective of the project was to identify transactions that deviate from expected user spending behavior.

The analysis uses transaction-level and user-level behavioral features to identify unusual activity.

The final dataset contains:

- Anomaly indicator
- Anomaly score
- Risk classification

Transactions were classified into:

- 🟢 **Low Risk**
- 🟠 **Medium Risk**
- 🔴 **High Risk**

This enabled the project to move beyond descriptive analytics into **transaction risk investigation**.

---

# 🗄️ SQL Business Analysis

SQL Server was used to perform business-focused analysis on the transaction dataset.

The SQL analysis includes:

- Category-level spending
- User-level spending
- Transaction success analysis
- Monthly transaction trends
- High-value transaction analysis
- Risk-level analysis
- Anomaly analysis
- Aggregations and ranking
- Subqueries
- CTEs
- Window functions
- Conditional aggregation
- Business-oriented filtering and segmentation

The SQL queries were designed around practical fintech business questions rather than only demonstrating SQL syntax.

---

# 📊 Power BI Dashboard

An interactive **4-page Power BI report** was developed to communicate the analytical findings.

## Page 1 — Executive Overview

Provides a high-level view of:

- Total spending
- Total transactions
- Unique users
- Average transaction value
- Anomaly rate
- High-risk transactions
- Monthly spending trends
- Category-level spending
- Risk distribution
  <img width="1316" height="737" alt="image" src="https://github.com/user-attachments/assets/46a170f7-5895-4c07-86b1-0fa6eb5453f3" />


---

## Page 2 — User Spending Behaviour

Focuses on customer-level behavioral analysis.

Visuals include:

- Unique users
- Total spend
- Average transaction value
- Transactions per user
- Spending by user persona
- Average transaction value by persona
- Weekday vs weekend spending
- Transaction activity by time of day
- Monthly spending trends by user persona
  <img width="1317" height="740" alt="image" src="https://github.com/user-attachments/assets/b4445d55-1950-40b7-a57e-29c8cc6c4bf7" />


---

## Page 3 — Anomaly & Risk Analysis

Focuses specifically on transaction risk.

Key metrics include:

- Total transactions
- Total anomalies
- Anomaly rate
- High-risk transactions
- Anomalous spend
- High-risk spend

Visual analysis includes:

- Transaction risk distribution
- Anomalous transactions by category
- High-risk spend by category
- Monthly anomaly trends
  <img width="1320" height="736" alt="image" src="https://github.com/user-attachments/assets/038b3260-43b8-4181-9086-6748f45ec7fa" />


---

## Page 4 — Transaction Investigation

Provides a detailed transaction-level view of anomalous activity.

The investigation table includes:

- Transaction ID
- User ID
- Transaction date
- Amount
- Category
- Anomaly indicator
- Risk level

Transactions are sorted by transaction value to help identify **high-value anomalous transactions requiring further investigation**.
<img width="1310" height="737" alt="image" src="https://github.com/user-attachments/assets/544601e5-a8b2-476b-8585-7000137d6542" />
<img width="1321" height="742" alt="image" src="https://github.com/user-attachments/assets/aae74a65-06af-43d8-9b81-acc2aeed1227" />



---

# 📌 Key Project Metrics

The final Power BI analysis produced approximately:

| Metric | Result |
|---|---:|
| Total Transactions | **152K** |
| Total Anomalies | **10K** |
| Anomaly Rate | **6.35%** |
| High-Risk Transactions | **6K** |
| Anomalous Spend | **₹239.03M** |
| High-Risk Spend | **₹157.89M** |
| Average Transaction Value | **₹6.53K** |
| Unique Users | **~1K+** |

> All financial values are generated from synthetic data and do not represent real customer transactions.

---

# 💡 Key Business Insights

The analysis highlights several important patterns:

### 1. Spending is concentrated in major consumer categories

Shopping and Travel represent significant contributors to overall transaction value, making them important categories for monitoring customer spending behavior.

### 2. User personas behave differently

High Spenders and Working Professionals contribute substantially to total spending, while different personas show distinct average transaction values and transaction frequencies.

### 3. Transaction behavior varies by time

Evening transactions represent a major share of transaction activity, highlighting the importance of time-based behavioral analysis.

### 4. Anomalous activity represents meaningful financial exposure

Although anomalous transactions represent a relatively small proportion of total transactions, they are associated with substantial transaction value.

### 5. High-risk activity requires transaction-level investigation

The risk dashboard helps move from aggregate reporting to individual transaction investigation, allowing analysts to identify high-value suspicious activity for further review.

---

# 🎯 Business Recommendations

Based on the analysis, a fintech organization could:

- Monitor unusually high-value transactions more closely.
- Use user-level spending patterns to improve anomaly detection.
- Apply different risk thresholds for different user segments.
- Prioritize high-risk categories for transaction monitoring.
- Monitor unusual changes in spending frequency or amount.
- Build automated alerts for high-value anomalous transactions.
- Use persona-based analysis to improve customer segmentation.
- Combine behavioral signals with transaction risk scoring for stronger fraud-monitoring workflows.

---

# 📁 Project Structure

```text
UPI-SpendSense-Personal-Finance-Spending-Pattern-Analysis/
│
├── data/
│   └── UPI transaction datasets
│
├── notebooks/
│   └── UPI_Spending_Analysis.ipynb
│
├── sql/
│   └── SQL business analysis queries
│
├── powerbi/
│   └── UPI_SpendSense_Personal_Finance_Analytics.pbix
│
├── screenshots/
│   ├── page1_executive_overview.png
│   ├── page2_user_spending_behaviour.png
│   ├── page3_anomaly_risk_analysis.png
│   └── page4_transaction_investigation.png
│
└── README.md
