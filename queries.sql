-- SuperStore Sales & Profitability Analysis
-- All queries written and tested in DB Browser for SQLite
-- Dataset: SuperStore Orders (102,581 rows), sourced from Kaggle

-- ============================================
-- Query 1: Total Sales & Profit by Category
-- ============================================
SELECT category,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(sales), 2) AS total_sales
FROM SuperStoreOrders
GROUP BY category
ORDER BY total_profit DESC;

-- ============================================
-- Query 2: Sales & Profit by Region
-- ============================================
SELECT region,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(sales), 2) AS total_sales
FROM SuperStoreOrders
GROUP BY region
ORDER BY total_profit DESC;

-- ============================================
-- Query 3: Top 10 Most Profitable Products
-- ============================================
SELECT product_name,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(sales), 2) AS total_sales
FROM SuperStoreOrders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- ============================================
-- Query 4: Sales & Profit by Customer Segment
-- ============================================
SELECT segment,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(sales), 2) AS total_sales
FROM SuperStoreOrders
GROUP BY segment
ORDER BY total_profit DESC;
-- Manual follow-up: profit margin per segment = total_profit / total_sales
-- Home Office ≈ 19.7% | Corporate ≈ 18.7% | Consumer ≈ 18.5%

-- ============================================
-- Query 5: Yearly Sales & Profit Trend
-- ============================================
SELECT year,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(sales), 2) AS total_sales
FROM SuperStoreOrders
GROUP BY year
ORDER BY year ASC;

-- ============================================
-- Query 6: Profit Margin & Status by Sub-Category
-- ============================================
SELECT sub_category,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin,
       CASE
           WHEN SUM(profit) / SUM(sales) * 100 >= 8 THEN 'Profitable'
           WHEN SUM(profit) / SUM(sales) * 100 >= 0 AND SUM(profit) / SUM(sales) * 100 < 8 THEN 'Low Margin'
           ELSE 'Loss'
       END AS profit_status
FROM SuperStoreOrders
GROUP BY sub_category
ORDER BY profit_margin;

-- ============================================
-- Query 7: States/Regions Operating at a Net Loss
-- ============================================
SELECT state,
       ROUND(SUM(profit), 2) AS total_profit
FROM SuperStoreOrders
GROUP BY state
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

-- ============================================
-- Query 8: Discount Impact on Profit by Category
-- ============================================
SELECT category,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(AVG(discount), 2) AS avg_discount,
       ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM SuperStoreOrders
GROUP BY category
ORDER BY total_profit ASC;
