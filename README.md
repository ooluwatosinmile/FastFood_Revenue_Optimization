# 📈 SQL EDA: Driving High Margin Revenue in Multi-National Sales

## 🎯 Executive Summary

This project conducts an Exploratory Data Analysis (EDA) on fast-food sales data from five European cities using **SQL** for all aggregation and analysis.

The analysis identified key revenue opportunities and operational weaknesses:

* **High Margin Focus:** Burgers are the highest margin product (Avg Price: $12.99), but low sales volume prevents them from driving maximum profit.
* **Critical Weakness:** Sales volume drops by approximately **70% every Sunday**, representing the largest revenue recovery opportunity.
* **Actionable Strategy:** The final analysis isolated the top two high margin performers, **Joao Silva (Lisbon)** and **Tom Jackson (London)**, who represent successful models for **In-store** and **Online** high margin sales, respectively.
---

## 🛠️ Methodology and Project Files

The entire analysis was performed using **SQL** to aggregate and segment data, ensuring accuracy and efficiency across the large dataset. The final insights were derived by combining key results from multiple queries.

### Project Files:

* **`eda_queries.sql`**: Contains the full script of all 15+ SQL queries used for the analysis, including initial cleaning checks, univariate, and multivariate aggregations.
* **`README.md`**: The current document, presenting the final narrative and actionable strategy.
* **`sample_data.csv`**: A small sample of the dataset structure for context and replication.

---
## 🔎 Key Findings and Analysis

### 1. Product Unit Economics (The Margin Opportunity)

The analysis of revenue, volume, and average price confirmed that the focus must be on high margin products like **Burgers**.

| Product | Avg. Price | Total Volume | Total Revenue |
| :--- | :--- | :--- | :--- |
| **Burgers** | $12.99 | 2,234 | $29,022.31 |
| Chicken Sandwiches | $10.32 | 1,095 | $11,135.92 |
| Beverages | $2.95 | 11,868 | $34,983.14 |

**Insight:** Burgers drive the highest per unit value, but their low volume compared to Beverages (11,868 units) indicates a major untapped sales opportunity.

---

### 2. Operational Profit Benchmarking (The Synthesis)

The final step was linking the high margin products (Burgers/Sandwiches) to operational success, isolating the top performers.

**SQL Query (Final Synthesis):**
```sql
SELECT Manager, City, SUM(CASE WHEN Product IN ('Burgers', 'Chicken Sandwiches') THEN Total_Amount ELSE 0 END) AS High_Margin_Revenue
FROM sales_data1
GROUP BY Manager, City
ORDER BY High_Margin_Revenue DESC;
```

| Rank | Manager        | City   | High-Margin Revenue |
| :--- | :------------- | :----- | ------------------- |
| **1** | **Joao Silva**     | **Lisbon** | **$11,672.21** |
| **2** | **Tom Jackson**    | **London** | **$11,052.98** |
| 3 | Pablo Perez     | Madrid | $7,474.97 |
| 4 | Walter Muller   | Berlin | $5,718.91 |


Key Finding: Joao Silva (In-store focused, Lisbon) and Tom Jackson (Online focused, London) are the benchmarks for driving premium product revenue in different channel environments.

## 🚀 Actionable Strategic Roadmap

Based on the complete EDA, the following three strategies are recommended for immediate implementation:

### 1. Model Managerial Excellence by Channel
 **Action:** Document and train the techniques of **Joao Silva** (In-store high-margin selling) and **Tom Jackson** (Online high margin selling) to standardize best practices across all cities.
 **Target:** Implement training on low performing managers like Walter Muller and Pablo Perez to lift high margin revenue.

### 2. Attack the Sunday Revenue Dip
 **Action:** Launch dedicated, channel specific promotions for the high margin **Burgers** to recover the **70% revenue gap** on Sundays.
 **Strategy:** Use an **Online focused promotion** for digital cities (like London) and an **In-store family bundle** for physical heavy cities (like Lisbon/Madrid).

### 3. Review Chicken Sandwich Positioning
 **Action:** Investigate why Chicken Sandwiches, despite a high price point, have low volume. The issue is likely the product's perceived value or market positioning, not the price itself.
