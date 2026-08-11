/*
============================================================
PROJECT: UPI SpendSense - Personal Finance & Spending Pattern Analysis
DATABASE: UPI_SpendSense_DB
AUTHOR: Tanishtha Shrivastava
OBJECTIVE:
To analyze UPI transaction behavior, spending patterns, user segments,
merchant performance, and anomaly/risk patterns using SQL Server.*/
USE UPI_SpendSense_DB;
GO

/*
QUERY 1: Overall UPI Transaction KPIs
BUSINESS PURPOSE:
Provides a high-level overview of transaction activity, successful payments, total spending, average transaction value, and overall anomaly rate.*/

SELECT
    COUNT(*) AS Total_Transactions,
    SUM(
        CASE 
            WHEN Payment_Status = 'Successful' THEN 1 
            ELSE 0 
        END
    ) AS Successful_Transactions,
    CAST(
        SUM(
            CASE 
                WHEN Payment_Status = 'Successful' THEN 1 
                ELSE 0 
            END
        ) * 100.0 / COUNT(*)
    AS DECIMAL(10,2)) AS Success_Rate_Percent,
    SUM(Amount) AS Total_Transaction_Value,
    AVG(Amount) AS Average_Transaction_Value,
    SUM(CAST(Is_Anomaly AS INT)) AS Total_Anomalies,
    CAST(
        SUM(CAST(Is_Anomaly AS INT)) * 100.0
        / COUNT(*)
    AS DECIMAL(10,2)) AS Anomaly_Rate_Percent
FROM dbo.UPI_Transactions;

/*
QUERY 2: Category-wise Spending Analysis
BUSINESS PURPOSE:
Identifies categories generating the highest transaction volume and total spending value.*/
SELECT
    Category,    
    COUNT(*) AS Transaction_Count,    
    SUM(Amount) AS Total_Spend,    
    AVG(Amount) AS Avg_Transaction_Value,
    RANK() OVER (
        ORDER BY SUM(Amount) DESC
    ) AS Spend_Rank
FROM dbo.UPI_Transactions
WHERE LTRIM(RTRIM(Payment_Status)) = 'Success'
GROUP BY Category
ORDER BY Spend_Rank;

/*
QUERY 3: Top 10 Highest-Spending Users
BUSINESS PURPOSE:
Identifies high-value users who may be suitable for premiumfinancial products, rewards, or personalized offers.
*/
SELECT TOP 10
    User_ID,
    User_Persona,
    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Spend,
    AVG(Amount) AS Avg_Transaction_Value,
    RANK() OVER (
        ORDER BY SUM(Amount) DESC
    ) AS User_Spend_Rank
FROM dbo.UPI_Transactions
WHERE Payment_Status = 'Success'
GROUP BY
    User_ID,
    User_Persona
ORDER BY Total_Spend DESC;

/*
QUERY 4: Monthly Spending Trend and Month-over-Month Growth
BUSINESS PURPOSE:
Tracks how successful transaction spending changes over time and identifies periods of spending growth or decline.*/
WITH Monthly_Spending AS (    
    SELECT
        Year,
        Month,
        SUM(Amount) AS Total_Spend    
    FROM dbo.UPI_Transactions    
    WHERE Payment_Status = 'Success'    
    GROUP BY
        Year,
        Month
),
Monthly_With_Previous AS (
    SELECT
        *,
        LAG(Total_Spend) OVER (
            ORDER BY Year,
                     CASE Month
                         WHEN 'January' THEN 1
                         WHEN 'February' THEN 2
                         WHEN 'March' THEN 3
                         WHEN 'April' THEN 4
                         WHEN 'May' THEN 5
                         WHEN 'June' THEN 6
                         WHEN 'July' THEN 7
                         WHEN 'August' THEN 8
                         WHEN 'September' THEN 9
                         WHEN 'October' THEN 10
                         WHEN 'November' THEN 11
                         WHEN 'December' THEN 12
                     END
        ) AS Previous_Month_Spend    
    FROM Monthly_Spending
)
SELECT
    Year,
    Month,
    Total_Spend,
    Previous_Month_Spend,
    CAST(
        (Total_Spend - Previous_Month_Spend)
        * 100.0
        / NULLIF(Previous_Month_Spend, 0)
    AS DECIMAL(10,2)) AS MoM_Growth_Percent
FROM Monthly_With_Previous
ORDER BY
    Year,
    CASE Month
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END;

/*
QUERY 5: Spending Behavior by User Persona
BUSINESS PURPOSE:
Compares transaction frequency, total spending, average transaction value, and anomaly volume across different user personas.*/

SELECT
    User_Persona,

    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Spend,
    AVG(Amount) AS Avg_Transaction_Value,
    SUM(CAST(Is_Anomaly AS INT)) AS Anomaly_Count,
    CAST(
        SUM(CAST(Is_Anomaly AS INT)) * 100.0 / COUNT(*)
    AS DECIMAL(10,2)) AS Anomaly_Rate_Percent
FROM dbo.UPI_Transactions
WHERE Payment_Status = 'Success'
GROUP BY User_Persona
ORDER BY Total_Spend DESC;

/*
QUERY 6: Weekday vs Weekend Spending Behavior
BUSINESS PURPOSE:
Identifies differences in transaction frequency and spending value between weekdays and weekends.*/

SELECT
    Day_Type,
    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Spend,
    AVG(Amount) AS Avg_Transaction_Value,
    CAST(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER ()
    AS DECIMAL(10,2)) AS Transaction_Share_Percent
FROM dbo.UPI_Transactions
WHERE Payment_Status = 'Success'
GROUP BY Day_Type
ORDER BY Total_Spend DESC;

/*
QUERY 7: Top 10 Merchants by Transaction Value
BUSINESS PURPOSE:
Identifies merchants receiving the highest successful UPI transaction value. Useful for partnership, cashback, and merchant performance strategies.*/

WITH Merchant_Performance AS (
    SELECT
        Merchant,
        COUNT(*) AS Transaction_Count,
        SUM(Amount) AS Total_Spend,
        AVG(Amount) AS Avg_Transaction_Value,

        DENSE_RANK() OVER (
            ORDER BY SUM(Amount) DESC
        ) AS Merchant_Rank
    FROM dbo.UPI_Transactions
    WHERE Payment_Status = 'Success'
    GROUP BY Merchant
)
SELECT
    Merchant,
    Transaction_Count,
    Total_Spend,
    Avg_Transaction_Value,
    Merchant_Rank
FROM Merchant_Performance WHERE Merchant_Rank <= 10 ORDER BY Merchant_Rank;

/*
QUERY 8: Category-wise Anomaly Rate
BUSINESS PURPOSE:
Identifies categories with the highest proportion of unusual
or high-risk transactions. A high anomaly rate may indicate unusual user behavior that requires further investigation.*/

SELECT
    Category,
    COUNT(*) AS Total_Transactions,
    SUM(CAST(Is_Anomaly AS INT)) AS Anomaly_Count,
    CAST(
        SUM(CAST(Is_Anomaly AS INT)) * 100.0
        / COUNT(*)
    AS DECIMAL(10,2)) AS Anomaly_Rate_Percent,
    AVG(Anomaly_Score) AS Avg_Risk_Score
FROM dbo.UPI_Transactions WHERE Payment_Status = 'Success'
GROUP BY Category ORDER BY Anomaly_Rate_Percent DESC;

/*
QUERY 9: High-Risk Transaction Investigation
BUSINESS PURPOSE:
Retrieves high-risk transactions and shows the specific behavioral signals that contributed to the anomaly score. This supports explainable anomaly analysis.*/

SELECT TOP 20
    Transaction_ID,
    User_ID,
    User_Persona,
    Transaction_Date,
    Transaction_Time,
    Category,
    Merchant,
    Amount,
    User_Avg_Spend,
    Amount_Ratio_to_Avg,
    Daily_Total_Spend,
    Anomaly_Score,
    Risk_Level,
    CASE
        WHEN Is_Unusual_Amount = 1
        THEN 'Unusual transaction amount'
        ELSE ''
    END AS Amount_Signal,
    CASE
        WHEN Is_Category_Anomaly = 1
        THEN 'Category-level deviation'
        ELSE ''
    END AS Category_Signal,
    CASE
        WHEN Is_Late_Night_High_Value = 1
        THEN 'Late-night high-value transaction'
        ELSE ''
    END AS Time_Signal,
    CASE
        WHEN Is_Daily_Spending_Spike = 1
        THEN 'Daily spending spike'
        ELSE ''
    END AS Daily_Spend_Signal
FROM dbo.UPI_Transactions
WHERE Risk_Level = 'High' ORDER BY
    Anomaly_Score DESC,
    Amount DESC;

/*
QUERY 10: Users with the Highest Anomaly Rate
BUSINESS PURPOSE:
Identifies users whose transaction history contains a relatively high proportion of unusual transactions.*/
WITH User_Risk AS (
    SELECT
        User_ID,
        User_Persona,
        COUNT(*) AS Total_Transactions,
        SUM(CAST(Is_Anomaly AS INT)) AS Anomaly_Count,
        CAST(
            SUM(CAST(Is_Anomaly AS INT)) * 100.0
            / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)) AS Anomaly_Rate_Percent
    FROM dbo.UPI_Transactions
    WHERE Payment_Status = 'Success'
    GROUP BY
        User_ID,
        User_Persona
)
SELECT TOP 20
    *,    
    DENSE_RANK() OVER (
        ORDER BY Anomaly_Rate_Percent DESC
    ) AS Risk_Rank
FROM User_Risk ORDER BY
    Anomaly_Rate_Percent DESC,
    Anomaly_Count DESC;

/*
QUERY 11: Transactions Significantly Above User Spending Baseline
BUSINESS PURPOSE:
Finds transactions where the amount is at least 3x the user's average transaction value. 
This is useful for identifying potentially unusual spending behavior even outside the existing anomaly flag.*/
SELECT
    Transaction_ID,
    User_ID,
    User_Persona,
    Category,
    Merchant,
    Amount,
    User_Avg_Spend,
    Amount_Ratio_to_Avg,
    CASE
        WHEN Amount_Ratio_to_Avg >= 5 THEN 'Extremely High'
        WHEN Amount_Ratio_to_Avg >= 3 THEN 'Significantly High'
        ELSE 'Moderately High'
    END AS Deviation_Level FROM dbo.UPI_Transactions
WHERE
    Payment_Status = 'Success'
    AND Amount_Ratio_to_Avg >= 3 ORDER BY Amount_Ratio_to_Avg DESC;

/*
QUERY 12: Spending Volatility by User Persona
BUSINESS PURPOSE:
Measures which user personas have the highest variation in transaction amounts. Higher standard deviation indicates more variable spending behavior.*/
SELECT
    User_Persona,
    COUNT(*) AS Transaction_Count,
    AVG(Amount) AS Avg_Transaction_Value,
    STDEV(Amount) AS Spending_Volatility,
    CAST(
        STDEV(Amount) * 100.0
        / NULLIF(AVG(Amount), 0)
    AS DECIMAL(10,2)) AS Coefficient_of_Variation_Percent
FROM dbo.UPI_Transactions WHERE Payment_Status = 'Success'
GROUP BY User_Persona ORDER BY Coefficient_of_Variation_Percent DESC;

/* QUERY 13: Category Contribution to Total Spending
BUSINESS PURPOSE:
Calculates how much each spending category contributes to total successful transaction value.*/
WITH Category_Spending AS (
    SELECT
        Category,
        SUM(Amount) AS Total_Spend
    FROM dbo.UPI_Transactions WHERE Payment_Status = 'Success' GROUP BY Category
)
SELECT
    Category,
    Total_Spend,
    CAST(
        Total_Spend * 100.0
        / SUM(Total_Spend) OVER ()
    AS DECIMAL(10,2)) AS Contribution_Percent,
    DENSE_RANK() OVER (
        ORDER BY Total_Spend DESC
    ) AS Spend_Rank
FROM Category_Spending ORDER BY Spend_Rank;

/* QUERY 14: Monthly Spending Rank by User Persona
BUSINESS PURPOSE:
Ranks user personas by spending contribution within each month.*/
WITH Persona_Monthly_Spending AS (
    SELECT
        Year,
        Month,
        User_Persona,
        SUM(Amount) AS Total_Spend
    FROM dbo.UPI_Transactions WHERE Payment_Status = 'Success'
    GROUP BY
        Year,
        Month,
        User_Persona
)
SELECT
    Year,
    Month,
    User_Persona,
    Total_Spend,
    RANK() OVER (
        PARTITION BY Year, Month
        ORDER BY Total_Spend DESC
    ) AS Persona_Monthly_Rank
FROM Persona_Monthly_Spending
ORDER BY
    Year,
    CASE Month
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END,
    Persona_Monthly_Rank;

/* QUERY 15: User Spending Segmentation
BUSINESS PURPOSE:
Segments users based on their total successful spending and transaction frequency.
The resulting segments can support personalized offers, customer targeting, and financial product recommendations.*/
WITH User_Spending AS (
    SELECT
        User_ID,
        User_Persona,
        COUNT(*) AS Transaction_Count,
        SUM(Amount) AS Total_Spend,
        AVG(Amount) AS Avg_Transaction_Value
    FROM dbo.UPI_Transactions
    WHERE Payment_Status = 'Success'
    GROUP BY
        User_ID,
        User_Persona
)
SELECT
    User_ID,
    User_Persona,
    Transaction_Count,
    Total_Spend,
    Avg_Transaction_Value,
    CASE
        WHEN Total_Spend >= 500000
             AND Transaction_Count >= 100
        THEN 'High Value User'
        WHEN Total_Spend >= 250000
        THEN 'Medium Value User'
        ELSE 'Low Value User'
    END AS User_Segment
FROM User_Spending ORDER BY Total_Spend DESC;

/* QUERY 16: Executive UPI Analytics Summary
BUSINESS PURPOSE:
Provides key business metrics for decision-makers in a single output.*/
SELECT
    COUNT(*) AS Total_Transactions,
    COUNT(DISTINCT User_ID) AS Unique_Users,
    SUM(
        CASE
            WHEN LTRIM(RTRIM(Payment_Status)) = 'Success'
            THEN Amount
            ELSE 0
        END
    ) AS Successful_Transaction_Value,
    CAST(
        AVG(
            CASE
                WHEN LTRIM(RTRIM(Payment_Status)) = 'Success'
                THEN Amount
            END
        )
    AS DECIMAL(18,2)) AS Avg_Successful_Transaction,
    SUM(CAST(Is_Anomaly AS INT)) AS Total_Anomalies,
    CAST(
        SUM(CAST(Is_Anomaly AS INT)) * 100.0
        / NULLIF(COUNT(*), 0)
    AS DECIMAL(10,2)) AS Anomaly_Rate_Percent,
    SUM(
        CASE
            WHEN Risk_Level = 'High' THEN 1
            ELSE 0
        END
    ) AS High_Risk_Transactions
FROM dbo.UPI_Transactions;

